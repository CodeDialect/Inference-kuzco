
#!/bin/bash

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
NC='\033[0m'
RESET="\e[0m"

REQUIRED_PKGS=(sudo curl wget lsof pciutils screen)

# BANNER
echo -e "${GREEN}"
cat << 'EOF'
 ______              _         _                                             
|  ___ \            | |       | |                   _                        
| |   | |  ___    _ | |  ____ | | _   _   _  ____  | |_   ____   ____  _____ 
| |   | | / _ \  / || | / _  )| || \ | | | ||  _ \ |  _) / _  ) / ___)(___  )
| |   | || |_| |( (_| |( (/ / | | | || |_| || | | || |__( (/ / | |     / __/ 
|_|   |_| \___/  \____| \____)|_| |_| \____||_| |_| \___)\____)|_|    (_____)
EOF
echo -e "${NC}"

# Check for sudo or root
echo -e "${YELLOW}Checking user privileges...${RESET}"
IS_ROOT=0
if [ "$(id -u)" -ne 0 ]; then
  if ! command -v sudo &>/dev/null; then
    echo -e "${RED}sudo not installed and you are not root. Cannot proceed.${RESET}"
    exit 1
  fi
  IS_ROOT=1
fi
SUDO=""
[ "$IS_ROOT" -eq 1 ] && SUDO="sudo"

# Update & install dependencies
echo -e "${YELLOW}Updating package list...${RESET}"
$SUDO apt update -y

for pkg in "${REQUIRED_PKGS[@]}"; do
  if ! dpkg -s "$pkg" &>/dev/null; then
    echo -e "${YELLOW}Installing $pkg...${RESET}"
    $SUDO apt install -y "$pkg"
  else
    echo -e "${GREEN}$pkg is already installed.${RESET}"
  fi
done

# Install CUDA if nvcc not found
if ! command -v nvcc &>/dev/null; then
  echo -e "${YELLOW}CUDA not found. Installing NVIDIA CUDA Toolkit...${RESET}"
  $SUDO apt install -y nvidia-cuda-toolkit
else
  echo -e "${GREEN}CUDA is already installed.${RESET}"
fi

# Prompt for Worker ID
echo -ne "${YELLOW}Enter your Worker ID (will be used with --code): ${RESET}"
read -r WORKER_ID

# Install Inference CLI from GitHubusercontent
echo -e "${CYAN}Installing Inference Node CLI...${RESET}"
curl -fsSL https://devnet.inference.net/install.sh | sh

echo -e "${GREEN}🧹 Closing any existing 'inference' screen sessions...${NC}"
screen -ls | grep -o '[0-9]*\.inference-node' | while read -r session; do
  screen -S "${session%%.*}" -X quit
done
# Start node in screen session
SESSION_NAME="inference-node"
echo -e "${CYAN}Starting node in screen session '$SESSION_NAME'...${RESET}"
screen -dmS "$SESSION_NAME" bash -c "inference node start --code $WORKER_ID; exec bash"

# Output
echo -e "\n${GREEN}✅ Inference Node started with Worker ID: $WORKER_ID${RESET}"
echo -e "${CYAN}To view session:${RESET} ${YELLOW}screen -r $SESSION_NAME${RESET}"
echo -e "${CYAN}To detach:${RESET} ${YELLOW}Ctrl+A then D${RESET}\n"
