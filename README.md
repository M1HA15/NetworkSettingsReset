# 🌐 Network Settings Reset (**NSR**)

## 🚀 A Simple and Efficient Solution for Network Maintenance on Windows

The Network Settings Reset Script is a powerful yet user-friendly Windows batch script designed to simplify the process of resetting and maintaining network settings. It's perfect for users who want to optimize their network configurations, resolve connectivity issues, or refresh DNS settings with just a few clicks.

## 💻 Key Features

- ⛔ **Administrator Privileges Check:** Ensures seamless execution by verifying that the script is run with administrator privileges.

- 📊 **Comprehensive Network Maintenance Tasks:**
  - **Flushing DNS:** Clears the DNS resolver cache for improved performance.
  - **Registering DNS:** Refreshes DHCP leases and re-registers DNS names.
  - **Releasing IP:** Releases the current IP address configuration.
  - **Renewing IP:** Obtains a new IP address configuration from a DHCP server.
  - **Resetting Winsock:** Resets the Winsock catalog to its default state.
  - **Setting DNS Provider:** Allows users to choose their preferred DNS provider for enhanced browsing security and speed.

    Choose from popular DNS providers:
    - Cloudflare (1.1.1.1)
    - Cisco Umbrella (208.67.222.222)
    - GCore (95.85.95.85)
    - Quad9 (9.9.9.9)
    - Google (8.8.8.8)

  - **Script automatically pings the recommended DNS providers** for optimal performance before making a selection.

  - Additionally, you can **input your custom DNS provider**, supporting both IPv4 and IPv6.

- 🤝 **User-Friendly Restart Option:** After completing network tasks, the script prompts users to restart their computers for changes to take effect.

## ⚙️ Usage

1. **📁 Download:** 
Get the latest version of the script from the [Releases](https://github.com/M1HA15/Network-Settings-Reset/releases) page.

2. **🛡️ Run with Administrator Privileges:**
   ```bash
   > NSR.bat
   ```
   
3. **🌎 Choose DNS Provider (Optional):**
   ```bash
   [6] Set DNS provider:
      [1] Recommended DNS Providers
      [2] Input your DNS Providers
      [3] Skip

   Choose DNS provider (1-3): 1

   Testing DNS providers to find the best one for you...
   1.1.1.1: Minimum = 3ms, Maximum = 4ms, Average = 3ms
   208.67.222.222: Minimum = 47ms, Maximum = 48ms, Average = 47ms
   95.85.95.85: Minimum = 3ms, Maximum = 4ms, Average = 3ms
   9.9.9.9: Minimum = 4ms, Maximum = 4ms, Average = 4ms
   8.8.8.8: Minimum = 17ms, Maximum = 18ms, Average = 17ms

   Testing complete! The DNS provider with the lowest ping times may be the best choice for you.


   Choose a recommended DNS provider:
      [1] Cloudflare (1.1.1.1)
      [2] Cisco Umbrella (208.67.222.222)
      [3] GCore (95.85.95.85)
      [4] Quad9 (9.9.9.9)
      [5] Google (8.8.8.8)

   Enter your choice (1-5): 1

   Primary IPv4 DNS set to 1.1.1.1
   Secondary IPv4 DNS set to 1.0.0.1
   Primary IPv6 DNS set to 2606:4700:4700::1111
   Secondary IPv6 DNS set to 2606:4700:4700::1001
   ```
   ```bash
   [6] Set DNS provider:
      [1] Recommended DNS Providers
      [2] Input your DNS Providers
      [3] Skip

   Choose DNS provider (1-3): 2

   Do you want to visit DNSPerf to choose a DNS provider? (Y/N): Y

   Please input the IPv4 and IPv6 addresses of the selected DNS provider!
   Enter your primary IPv4 DNS address: 95.85.95.85
   Enter your secondary IPv4 DNS address: 2.56.220.2
   Enter your primary IPv6 DNS address: 2a03:90c0:999d::1
   Enter your secondary IPv6 DNS address: 2a03:90c0:9992::1
   Please wait a moment while we configure the desired addresses for the selected DNS provider.

   Primary IPv4 DNS set to 95.85.95.85
   Secondary IPv4 DNS set to 2.56.220.2
   Primary IPv6 DNS set to 2a03:90c0:999d::1
   Secondary IPv6 DNS set to 2a03:90c0:9992::1
   ```

4. **🚀 NSR GitHub Page (Optional):**
   ```bash
   Do you want to open the GitHub page of this project? (Y/N): Y
   Opening default web browser...
   ```

5. **🌌 Restart (Optional):**
If desired, restart your computer to apply the network settings changes.
     ```bash
     Do you want to restart the computer now? (Y/N): Y
     We appreciate you using the script. Your computer will restart shortly!
     ```

## ⚠️ Disclaimer
Use this script at your own risk. Be sure to understand the implications of resetting network settings on your system before running the script.

## 📝 Contributing
We welcome contributions! Please read the [Contributing Guidelines](https://github.com/M1HA15/Network-Settings-Reset/blob/main/CONTRIBUTING.md) before submitting issues or pull requests.

## 🚧 Report Issues
If you encounter any issues, please [report them here](https://github.com/M1HA15/Network-Settings-Reset/issues).

Your feedback is valuable in improving the script!

## 👤 Author
- **[Mihai](https://github.com/M1HA15)**

## 👥 Contributors
- **[Rad](https://github.com/RadNotRed)**

## 📃 License
This project is licensed under the GPL-3.0 License - see the [LICENSE](https://github.com/M1HA15/Network-Settings-Reset/blob/main/LICENSE) file for details.
