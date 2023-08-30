# GPTContextEngine
Demonstrate ChatGPT context engine for 'universal translate'. This demonstrates real-time translation ability for Powershell and Command Prompt. 
This is beta demo. 

# What it does? 

Press Ctrl-Space to open input field. It will detect the current context: Powershell or Command and translate your natural language into its best guess 
of the appropriate command. This is a demo and there are some natural improvements possible.

**Caution*** Exercise extreme care with any executed commands. Do not use for critical or production applications.

Components:

1. I updated the Chrome TamperMonkey Script updated/fixed from [https://github.com/CurtisAccelerate/chatgpt-api-by-browser-script](https://github.com/zsodur/chatgpt-api-by-browser-script)https://github.com/zsodur/chatgpt-api-by-browser-script  for GUI changes.
2. Zsodur's ChatGPT Server script. This is not required if connecting to OpenAI API vs ChatGPT but API will need changed slightly.
3. AutoHotKey script adapted from my GPTAnywhere pattern.

Quick start:

1. Install the TamperMonkey script included into Chrome.
2. Start the zsodur node.js server from https://github.com/zsodur/chatgpt-api-by-browser-script
2.1 npm install
2.2 npm start
4. Load and run the AHK script. I use Scite4AHK for this.



   




