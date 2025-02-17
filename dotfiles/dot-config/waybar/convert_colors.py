import sys
import re
light_or_dark = sys.argv[3]

def rgb_to_hsl(r, g, b):
    r, g, b = r / 255.0, g / 255.0, b / 255.0
    maxc = max(r, g, b)
    minc = min(r, g, b)
    l = (maxc + minc) / 2.0
    if maxc == minc:
        s = h = 0
    else:
        d = maxc - minc
        s = d / (2 - maxc - minc) if l > 0.5 else d / (maxc + minc)
        if maxc == r:
            h = (g - b) / d + (6 if g < b else 0)
        elif maxc == g:
            h = (b - r) / d + 2
        else:
            h = (r - g) / d + 4
        h /= 6
    return h, s, l

def hsl_to_rgb(h, s, l):
    c = (1 - abs(2 * l - 1.0)) * s
    x = c * (1 - abs((h * 6) % 2 - 1))
    m = l - c / 2
    if h < 1 / 6:
        r, g, b = c, x, 0
    elif h < 2 / 6:
        r, g, b = x, c, 0
    elif h < 3 / 6:
        r, g, b = 0, c, x
    elif h < 4 / 6:
        r, g, b = 0, x, c
    elif h < 5 / 6:
        r, g, b = x, 0, c
    else:
        r, g, b = c, 0, x
    return int(round((r + m) * 255)), \
            int(round((g + m) * 255)), \
            int(round((b + m) * 255))

class Color:
    matcher = None
    splitter = None

    def __init__(self, m):
        self.red = int(m.group('red'), 16)
        self.green = int(m.group('green'), 16)
        self.blue = int(m.group('blue'), 16)


    def __repr__(self):
        return self.__str__()

    def convert(self, light_or_dark):
        h, s, l = rgb_to_hsl(self.red, self.green, self.blue)
        l = 1.0 - l
        if l >= 0.33 and l <= 0.66:
            # This is likely a background color, so we should make it more
            # of one or the other
            if light_or_dark == 'light':
                l += 0.33
            else:
                l -= 0.33

        self.red, self.green, self.blue = hsl_to_rgb(h, s, l)

    @classmethod
    def transform_line(cls, line, light_or_dark):
        '''
        Transform a line by "toggling" all colors' lightness in it
        '''
        matches = re.findall(cls.matcher, line)
        result_line = str(line)
        for match in matches:
            m = cls.splitter.search(match)
            if m is None:
                print(f'{cls.matcher} nuh uh {cls.splitter}')
            newColor = cls(m)
            newColor.convert(light_or_dark)
            print(f"New color: {match} -> {newColor}")
            result_line = result_line.replace(match, str(newColor))
        return result_line

class HexColor(Color):
    matcher = re.compile(r'#[0-9a-fA-F]{6}')
    splitter = re.compile(r'#(?P<red>[0-9a-fA-F]{2})(?P<green>[0-9a-fA-F]{2})(?P<blue>[0-9a-fA-F]{2})')

    def __init__(self, m):
        super().__init__(m)

    def __str__(self):
        return '#%02x%02x%02x' % (self.red, self.green, self.blue)

class RGBAColor(Color):
    matcher = re.compile(r'rgba\( *[0-9]+ *, *[0-9]+ *, *[0-9]+ *, *[0-9\.]+ *\)')
    splitter = re.compile(r'rgba\( *(?P<red>[0-9]+) *, *(?P<green>[0-9]+) *, *(?P<blue>[0-9]+) *, *(?P<alpha>[0-9\.]+) *\)')

    def __init__(self, m):
        super().__init__(m)
        self.alpha = float(m.group('alpha'))

    def __str__(self):
        return 'rgba(%d, %d, %d, %f)' % (self.red, self.green, self.blue, self.alpha)

with open(sys.argv[2], 'w') as f:
    with open(sys.argv[1], 'r') as g:
        for line in g:
            hexline = HexColor.transform_line(line, light_or_dark)
            rgbaline = RGBAColor.transform_line(hexline, light_or_dark)
            print(rgbaline, end='', file=f)
