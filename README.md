
# Inference DevNet Epoch 3 One-Click Node Setup

Welcome to the **Inference DevNet Epoch 3**!

This script provides a **fully automated setup** to run your Inference compute node on Linux with supported NVIDIA or AMD GPUs, or Apple Silicon. Contribute your GPU to earn rewards for participating in decentralized AI computation.

---

## Features

- One-command setup: `bash <(curl ...)`
- Installs: `sudo`, `curl`, `wget`, `lsof`, `pciutils`, `screen`, and `nvidia-cuda-toolkit`
- Automatically installs the Inference CLI
- Launches the node in a background `screen` session
- GPU and CUDA support check included

---

## Minimum System Requirements

| Component           | Requirement                                                   |
|---------------------|---------------------------------------------------------------|
| **GPU**             | See supported list below. Must have ** 16GB VRAM**           |
| **RAM**             | Minimum **16GB system memory**                                |
| **Disk Space**      | At least **30GB** of free disk space                          |
| **Network**         | Reliable **100 Mbps+ upload/download** [Test on Fast.com](https://fast.com) |
| **Operating System**| Ubuntu **20.04** or **22.04** (x86_64 architecture)           |
| **NVIDIA Driver**   | Version **525** required                                    |

---

## Supported GPUs

Your GPU must support **Compute Capability 7.0** and have **at least 16GB VRAM**.

### NVIDIA GPUs

- **RTX Series**: RTX 4090, 4080, 4000, 3090 Ti, 3090, 5000, 6000, 8000  
- **A Series**: A10, A30, A40, A100 (40GB/80GB), A4000, A5000, A6000  
- **TITAN**: TITAN RTX  
- **Quadro**: GP100, GV100, M6000 24GB, P5000, P5200, P6000  
- **Tesla**: P100, P40, T4, M60  

### AMD GPUs

- **MI Series**: MI60, MI100, MI200, MI210, MI250, MI250X, MI300, MI300A, MI300X  
- **Vega II**: Vega II, Vega II Duo  
- **Radeon Pro**: W6800, W6800X, W6800X Duo, W6900X, W7700, W7800, W7900  
- **Radeon RX**: 6800, 6800 XT, 6900 XT, 6900 XTX, 6950 XT, 7600 XT, 7800 XT, 7900 GRE, 7900 XT, 7900 XTX  
- **Others**: SSG, V340, VII  

>  All GPUs must have **at least 16GB of VRAM**

---

## Supported Apple Silicon Chips

- M1, M1 Pro, M1 Max, M1 Ultra  
- M2, M2 Pro, M2 Max, M2 Ultra

---

## Install Dependencies 
```bash
apt update && apt install curl -y
```

## Install & Run (One Liner)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Codedialect/Inference-kuzco/main/setup-inference-node.sh)
```

---

## During Setup

You'll be prompted for your **Worker ID** from Inference.

Example:

```bash
Enter your Worker ID (will be used with --code): bf8b65ae-1fd3-4a26-96b7-cfcf219092c7
```

The node will automatically start in a `screen` session:

```bash
inference node start --code <your-worker-id>
```

---

## Managing Your Node

- Reattach to your node:
  ```bash
  screen -r inference-node
  ```

- Detach and leave it running:  
  Press `Ctrl+A`, then `D`

- Stop the node:
  ```bash
  screen -S inference-node -X quit
  ```

---

## Official Resources

-  [Epoch 3 Documentation](https://docs.devnet.inference.net/devnet-epoch-3/overview)  
-  [Inference Website](https://inference.net)

---
