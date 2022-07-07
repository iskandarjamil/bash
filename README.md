# Bash Scripts

## Table of Contents
- [Fix permission](#fix-permission)
- [Scripts](#scripts)

## Scripts
1. [networktest.sh](#1-networktestsh)
1. [robot.sh](#2-robotsh)

### Fix permission
```bash
sudo chmod +x {script_name.sh}
```

### Scripts

#### 1. networktest.sh
Use `--url https://example.com,https://google.com` to execute directly without typing url
```bash
./networktest.sh
# or
bash networktest.sh

# with url
bash networktest.sh --url https://example.com,https://google.com
```

#### 2. robot.sh
Use `-I` or `--header` to only retrieve header
```bash
./robot.sh
# or
bash robot.sh

# only header
bash robot.sh -I
bash robot.sh --header
```
