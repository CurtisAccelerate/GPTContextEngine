# GPTContextEngine
Demonstrate ChatGPT context engine for 'universal translate'. This demonstrates real-time translation ability for Powershell and Command Prompt. 
This is beta demo. 

# What it does? 

Press Ctrl-Space to open input field. It will detect the current context: Powershell or Command Prompt and translate your natural language into its best guess 
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
4. Load and run the AHK script. I use Scite4AHK for this. You must install JSON library from https://github.com/cocobelgica/AutoHotkey-JSON in same directory.

Demo:
Press ctrl-space in a Command Prompt or Power Shell to get instant natural-language translation in-line with your application.

Ways to improvement:
1. Add additional info to help with context such as current directory, recent last commands and/or errors, etc.
2. Other GUI improvements

Known issues:
1. The submit button only works currently with code interpreter / advanced data analysis model selected. See get getnext sibling in the script which selects the button.
2. The window must be sized so the continue/regen button is visible.
   
   

   




