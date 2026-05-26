# 💡 Contributing to Network Settings Reset Script

Welcome and thank you for considering contributing to the [Network Settings Reset Script](https://github.com/M1HA15/Network-Settings-Reset). By contributing, you help make this project better for everyone.

## 📃 Table of Contents

- [Reporting Issues](#reporting-issues)
- [Feature Requests](#feature-requests)
- [Pull Requests](#pull-requests)
- [Code Style](#code-style)
- [Testing](#testing)
- [License](#license)

## 🔔 Reporting Issues

If you encounter any issues with the script, please check the existing [issues](https://github.com/M1HA15/Network-Settings-Reset/issues) to see if it has already been reported. If not, feel free to open a new issue with the following details:

- A clear description of the problem.
- Steps to reproduce the issue.
- Your Windows version and PowerShell version (visible in the script header).
- Any relevant error messages or screenshots.

## 🔨 Feature Requests

If you have a feature request, please open an issue to discuss the proposed feature and its implementation. We value your input and would love to hear your ideas!

## ⚒️ Pull Requests

If you'd like to contribute code to the project, please follow these steps:

1. Fork the repository and create a new branch for your contribution.
2. Make your changes and ensure the code is well-documented.
3. Test your changes thoroughly (see [Testing](#testing) below).
4. Update the `README.md` if your changes affect features, menus, or behavior.
5. Create a pull request to the `main` branch of the original repository with a clear description of what was changed and why.

## 🗂️ Code Style

Please adhere to the existing code style and formatting conventions used in the project. Key guidelines for this script:

- Use `goto` labels in `:camelCase` format (e.g. `:mainMenu`, `:changeDNS`).
- Keep menu headers consistent:
  ```batch
  echo ---------------------------------------------------------------------
  echo                      Section Name
  echo ---------------------------------------------------------------------
  ```
- Always handle invalid input with a clear message and a `timeout /nobreak /t 2 > nul` before looping back.
- Use PowerShell (`-Command`) for anything that requires adapter enumeration or TCP settings — avoid hardcoding interface names like `"Wi-Fi"` or `"Ethernet"`.
- Add `echo.` between logical blocks for readability.

## 🧪 Testing

Before submitting a pull request, please test your changes on a Windows machine with Administrator privileges. At a minimum, verify:

- The script launches correctly and the main menu displays as expected.
- Any new or modified menu options work without errors.
- Invalid inputs are handled gracefully (no crashes or unexpected exits).
- DNS changes apply correctly to active network adapters.
- The exit and restart flow works as intended.

If your changes affect the Bufferbloat Optimizer, consider verifying results with [WAVEFORM - Bufferbloat and Internet Speed Test](https://www.waveform.com/tools/bufferbloat).

## 📃 License

By contributing to this project, you agree that your contributions will be licensed under the [GPL-3.0 License](https://github.com/M1HA15/Network-Settings-Reset/blob/main/LICENSE).

Thank you for contributing to the Network Settings Reset Script!
