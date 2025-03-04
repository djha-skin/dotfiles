import copy
import re
import pprint
import sys
from pathlib import Path
import uuid
import os
# Go to company directory in Bamboo HR
# Select all, copy and paste to text file
# Then run this
# https://gist.github.com/gerwin3/ef9ae04d2b156c405db45dc70b93f716


"""
This little script can generate a valid .vcf (vCard). It will ask you to fill
in some details and write the vcf-file.
"""

NAMESPACE = uuid.UUID('991268fe-d292-11ef-b006-879e80384164')

def scrape(filename):
    find_name = re.compile(r'^(?P<first_name>[A-Z][A-Za-z\'-]*) (?P<last_name>.+)$')
    find_reports = re.compile(r'^Reports to (?P<boss_first_name>[A-Z][A-Za-z\'-]*) (?P<boss_last_name>.+)$')
    find_email = re.compile(r'(?P<email>[^@]+@[^@]+)$')
    find_out = re.compile(r'^OUT (?P<out_info>.+)$')
    find_phone_number = re.compile(r'^(?P<phone_number>[0-9-() ]+)$')
    find_extension = re.compile(r'^Ext(ension|\.) (?P<extension>[0-9]+)$')
    find_new_section = re.compile(r'^[A-Z]$')
    find_direct_reports = re.compile(r'^[0-9]+ direct reports?$')

    contacts = {}
    with open(filename, 'r', encoding='utf-8', errors='ignore') as f:
        line = f.readline()
        while line:
            contact = {}
            names = find_name.search(line)
            if not names:
                raise Exception('No name: ' + line)
            first_name = names.group('first_name').strip()
            last_name = names.group('last_name').strip()
            contact['first_name'] = first_name
            contact['last_name'] = last_name
            name_uuid = uuid.uuid5(NAMESPACE, f'{first_name} {last_name}')
            uuid_key = f'urn:uuid:{name_uuid}'
            contacts[uuid_key] = contact
            line = f.readline()
            if line is None:
                break
            contact['title'] = line.strip()
            contact['address'] = f.readline().strip()
            contact['company'] = f.readline().strip()
            line = f.readline()
            if line is None:
                break
            email_search = find_email.search(line)
            if email_search:
                contact['email'] = email_search.group('email').strip()
                line = f.readline()
                if line is None:
                    break
            pnsearch = find_phone_number.search(line)
            if pnsearch:
                contact['phone_number'] = pnsearch.group('phone_number').strip()
                line = f.readline()
                if line is None:
                    break
            es = find_extension.search(line)
            if es:
                contact['phone_number'] = contact['phone_number'] + ' Ext. ' + \
                        es.group('extension').strip()
                line = f.readline()
                if line is None:
                    break
            frs = find_reports.search(line)
            boss_first_name = None
            boss_last_name = None
            if frs:
                contact['boss_first_name'] = frs.group('boss_first_name').strip()
                contact['boss_last_name'] = frs.group('boss_last_name').strip()
                line = f.readline()
                if line is None:
                    break
            sdr = find_direct_reports.search(line)
            if sdr:
                line = f.readline()
                if line is None:
                    break
            so = find_out.search(line)
            if so:
                line = f.readline().strip()
                if line is None:
                    break
            sns = find_new_section.search(line)
            if sns:
                line = f.readline()
                if line is None:
                    break
    boss_contacts = copy.deepcopy(contacts)
    for aurn, arecord in contacts.items():
        if 'boss_first_name' in arecord:
            for burn, brecord in contacts.items():
                if arecord['boss_first_name'] == brecord['first_name'] and \
                    arecord['boss_last_name'] == brecord['last_name']:
                    boss_contacts[aurn]['boss_urn'] = burn
    return boss_contacts

def main():
    contacts = scrape('a')


    for curn, contact in contacts.items():
        first_name = contact.get('first_name')
        last_name = contact.get('last_name')
        clean_last_name = re.sub(r'\W', '_', last_name)
        company = contact.get('company')
        title = contact.get('title')
        phone_number = contact.get('phone_number')
        address = contact.get('address')
        email = contact.get('email')
        boss_urn = contact.get('boss_urn')
        vcard = make_vcard(curn, boss_urn, first_name, last_name, company, title, phone_number, address, email)
        sc = os.environ['SHORT_COMPANY_NAME']
        we = os.environ['WORK_EMAIL']
        vcf_file = f'/home/skin/Contacts/{sc}/{we}/{first_name.lower()}_{clean_last_name.lower()}.vcf'
        write_vcard(vcf_file, vcard)

def make_vcard(
        contact_urn,
        boss_urn,
        first_name,
        last_name,
        company,
        title,
        phone,
        address,
        email):
    address_formatted = ';'.join([p.strip() for p in address.split(',')])
    card = [
        'BEGIN:VCARD',
        'VERSION:2.1',
        f'UID:{contact_urn}'
        f'N:{last_name};{first_name}',
        f'FN:{first_name} {last_name}',
    ]
    if boss_urn:
        card.append('RELATED;TYPE=supervisor:{boss_urn}')
    if company:
        card.append(f'ORG:{company}')
    if title:
        card.append(f'TITLE:{title}')
    if email:
        card.append(f'EMAIL;PREF;INTERNET:{email}')
    if phone:
        card.append(f'TEL;WORK;VOICE:{phone}')
    if address:
        card.append(f'ADR;WORK;PREF:;;{address_formatted}')
    card.extend([f'REV:1', 'END:VCARD' ])

    return card

def write_vcard(f, vcard):
    with open(f, 'w') as f:
        f.writelines([l + '\n' for l in vcard])

if __name__ == "__main__":
    main()