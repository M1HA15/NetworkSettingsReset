# 🌐 Network Settings Reset (**NSR**)

## 🚀 Introduction:

Welcome to the Network Settings Reset Script – your go-to solution for streamlining network maintenance on Windows! If you've ever found yourself struggling with sluggish internet connections, mysterious connectivity issues, or simply want to fine-tune your network settings for optimal performance, you're in the right place.

## 🌟 Why Choose NSR?

- **Efficiency:** NSR is designed for efficiency, allowing you to perform crucial network tasks with just a few clicks.
- **User-Friendly:** No need to be a network expert – NSR simplifies complex tasks through a straightforward interface.
- **Flexibility:** Whether you're troubleshooting connectivity issues or customizing your DNS preferences, NSR has you covered.

## 💻 Key Features:

### 🔰 Administrator Privileges and PowerShell Check:

Ensures seamless execution by verifying that the script is run with administrator privileges and within a PowerShell environment. This script leverages PowerShell for applying DNS providers.

### ⚒️ Comprehensive Network Maintenance Tasks:

- **Flushing DNS Cache:** Clears the DNS resolver cache for improved performance.
- **Registering DNS:** Refreshes DHCP leases and re-registers DNS names.
- **Releasing IP Address:** Releases the current IP address configuration.
- **Renewing IP Address:** Obtains a new IP address configuration from a DHCP server.
- **Resetting Winsock:** Resets the Winsock catalog to its default state.
- **Setting DNS Provider:** Allows users to choose their preferred DNS Provider for enhanced browsing security and speed.

### 🌐 DNS Provider Options:

Choose from popular DNS Providers:
- **Cloudflare (1.1.1.1)**
- **Cisco Umbrella (208.67.222.222)**
- **GCore (95.85.95.85)**
- **Quad9 (9.9.9.9)**
- **Google (8.8.8.8)**

- **Custom DNS Provider:** If you have a specific DNS Provider in mind, you can input its details, and the script will apply your IPv4 and IPv6 DNS addresses across all active adapters.
- **Reset DNS to Default (DHCP):** Reverts all active network adapters back to automatic DNS assignment.
- **Ping Test:** The script includes an option to ping the recommended DNS Providers. Additionally, it allows you to input your custom DNS Provider for evaluation.

### 📈 Bufferbloat Optimization:

We have integrated a powerful script from [Khorvie Tech](https://github.com/Khorvie-Tech/bufferbloat) to tackle bufferbloat issues. Bufferbloat occurs when network latency increases due to excessive buffering, especially during high-bandwidth usage.

#### Features:
- **Advanced Registry Changes:** Applies tweaks to optimize TCP/IP settings for lower latency.
- **Dynamic Adapter Detection:** MTU settings are applied automatically to all active network adapters — no manual configuration needed.
- **Compatible with Modern Windows Versions:** Ensures smooth operation with the latest Windows builds.
- **Easy to Use:** The script runs seamlessly as part of the NSR process.

#### Testing Results:
To verify the improvements, we recommend using [WAVEFORM - Bufferbloat and Internet Speed Test](https://www.waveform.com/tools/bufferbloat) or similar tools.

### 🤝 User-Friendly Restart Option:

After completing the network tasks, the script provides a user-friendly prompt, allowing users to restart their computers for the changes to take full effect.

## ⚙️ Usage:

1. **📁 Download:** 
Get the latest version of the script from the [Releases](https://github.com/M1HA15/Network-Settings-Reset/releases) page.

2. **🛡️ Run with Administrator Privileges:**
   ```bash
   > NSR.bat
   ```

3. **🚨 Choose DNS Provider (Optional):**
   ```bash
   ---------------------------------------------------------------------
                        Change DNS Provider
   ---------------------------------------------------------------------

   [1] Recommended DNS Providers
   [2] Enter Your Provider
   [3] Reset DNS to Default (DHCP)
   [4] Back

   Enter your choice (1-4):
   ```

4. **📢 Explore the author's other project (Optional):**
   ```bash
   Do you want to check Cleany? (Y/N): Y
   Opening default web browser...
   ```

5. **🌌 Restart (Optional):**
If desired, restart your computer to apply the network settings changes.
   ```bash
   ---------------------------------------------------------------------
                            Exiting NSR
   ---------------------------------------------------------------------

   Do you want to restart the computer now? (Y/N): Y
     
   Thank you for utilizing the script! Your computer will restart shortly...
   ```

## 📋 Changelog:

### v0.9
- **Fixed:** DNS bug where IPv6 addresses overwrote IPv4 — both are now applied in a single adapter call.
- **Added:** Reset DNS to Default (DHCP) option under Change DNS Provider.
- **Improved:** Bufferbloat Optimizer now dynamically detects all active adapters for MTU configuration instead of relying on hardcoded interface names.
- **Improved:** Input validation across all menus.
- **Improved:** Minor UI and wording consistency updates.

### v0.8
- Initial public release.

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

## 🙏 Acknowledgments:
**Thank you for choosing NSR**! Special gratitude to you, the user, for your support and for choosing to utilize this script.

## 📃 License:
This project is licensed under the GPL-3.0 License - see the [LICENSE](https://github.com/M1HA15/Network-Settings-Reset/blob/main/LICENSE) file for details.
