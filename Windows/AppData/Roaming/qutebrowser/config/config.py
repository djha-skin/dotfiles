config.load_autoconfig()
config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --connection work.key --key A1F9E6A2696D3CAADEDB203C3812FEA997B503B6', mode='insert')
config.bind('PW', 'spawn --userscript qute-keepassxc --connection work.key --key A1F9E6A2696D3CAADEDB203C3812FEA997B503B6', mode='normal')
config.bind('PT', 'spawn --userscript qute-keepassxc --connection work.key --key A1F9E6A2696D3CAADEDB203C3812FEA997B503B6 --totp', mode='normal')
config.bind('<Alt-u>', 'spawn --userscript qute-keepassxc --connection home.key --key A1F9E6A2696D3CAADEDB203C3812FEA997B503B6', mode='insert')
config.bind('pw', 'spawn --userscript qute-keepassxc --connection home.key --key A1F9E6A2696D3CAADEDB203C3812FEA997B503B6', mode='normal')
config.bind('pt', 'spawn --userscript qute-keepassxc --connection home.key --key A1F9E6A2696D3CAADEDB203C3812FEA997B503B6 --totp', mode='normal')
