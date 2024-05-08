#!/bin/bash

OS=$(uname -s | awk '{print tolower($0)}')
ARCH=$(uname -m)

if [[ "$ARCH" =~ "aarch" ]]; then
ARCH="armv7"
fi

if [[ -f gitleaks ]]; then
    ./gitleaks detect --source . -v
else
    curl -s https://api.github.com/repos/gitleaks/gitleaks/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep "${OS}_${ARCH}" | wget -i - -O gitleaks.tag.gz -q

    tar -xf gitleaks.tag.gz gitleaks

    rm -f gitleaks.tag.gz

    chmod +x gitleaks

    ./gitleaks detect --source . -v
fi