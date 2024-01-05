# 🌐 Network Settings Reset (**NSR**)

## 🚀 Introduction:

Welcome to the Network Settings Reset Script – your go-to solution for streamlining network maintenance on Windows! If you've ever found yourself struggling with sluggish internet connections, mysterious connectivity hiccups, or simply want to fine-tune your network settings for optimal performance, you're in the right place.

## 🌟 Why Choose NSR?

- **Efficiency:** NSR is designed for efficiency, allowing you to perform crucial network tasks with just a few clicks.
- **User-Friendly:** No need to be a network expert – NSR simplifies complex tasks through a straightforward interface.
- **Flexibility:** Whether you're troubleshooting connectivity issues or customizing your DNS preferences, NSR has you covered.

## 💻 Key Features:

- 🔰 **Administrator Privileges and PowerShell Check**: Ensures seamless execution by verifying that the script is run with administrator privileges and within a PowerShell environment. This script leverages PowerShell for applying DNS providers.

- ⚒️ **Comprehensive Network Maintenance Tasks:**
  - **Flushing DNS:** Clears the DNS resolver cache for improved performance.
  - **Registering DNS:** Refreshes DHCP leases and re-registers DNS names.
  - **Releasing IP:** Releases the current IP address configuration.
  - **Renewing IP:** Obtains a new IP address configuration from a DHCP server.
  - **Resetting Winsock:** Resets the Winsock catalog to its default state.
  - **Setting DNS Provider:** Allows users to choose their preferred DNS Provider for enhanced browsing security and speed.

    Choose from popular DNS Providers:
    - Cloudflare (1.1.1.1)
    - Cisco Umbrella (208.67.222.222)
    - GCore (95.85.95.85)
    - Quad9 (9.9.9.9)
    - Google (8.8.8.8)

  - **Script automatically pings the recommended DNS Providers** for optimal performance before making a selection.

  - Additionally, you can **input your custom DNS Provider**, supporting both IPv4 and IPv6.

- 🤝 **User-Friendly Restart Option**: After completing the network tasks, the script provides a user-friendly prompt, allowing users to restart their computers for the changes to take full effect.

## ⚙️ Usage:

1. **📁 Download:** 
Get the latest version of the script from the [Releases](https://github.com/M1HA15/Network-Settings-Reset/releases) page.

2. **🛡️ Run with Administrator Privileges:**
   ```bash
   > NSR.bat
   ```
   
3. **🚨 Choose DNS Provider (Optional):**
   ```bash
   [6] DNS Provider:
     [1] Recommended DNS Providers
     [2] Test Recommended DNS Providers
     [3] Input your DNS Provider
     [4] Test your DNS Provider
     [5] Skip

   Enter your choice (1-5): 1
   ```

4. **📢 Explore the author's other project (Optional):**
   ```bash
   Want to check out our other project? (Y/N): Y
   Opening default web browser...
   ```

5. **🌌 Restart (Optional):**
If desired, restart your computer to apply the network settings changes.
     ```bash
     Do you want to restart the computer now? (Y/N): Y
     We appreciate you using the script. Your computer will restart shortly!
     ```

## ⚠️ Disclaimer:
This script is provided as-is, and the author takes no responsibility for any damage, loss of data, or unforeseen consequences caused by its usage. Additionally, be sure to understand the implications of the network maintenance tasks, including potential risks associated with resetting network settings and loss of data, before running NSR on your system! Use this script at your own risk!

## 📝 Contributing:
We welcome contributions! Please read the [Contributing Guidelines](https://github.com/M1HA15/Network-Settings-Reset/blob/main/CONTRIBUTING.md) before submitting issues or pull requests.

## 🚧 Report Issues:
If you encounter any issues, please [report them here](https://github.com/M1HA15/Network-Settings-Reset/issues).

Your feedback is valuable in improving the script!

## 🚀 Developers:
- **[Mihai (Author)](https://github.com/M1HA15)**
- **[Rad (Contributor)](https://github.com/RadNotRed)**

## 📃 License:
This project is licensed under the GPL-3.0 License - see the [LICENSE](https://github.com/M1HA15/Network-Settings-Reset/blob/main/LICENSE) file for details.
