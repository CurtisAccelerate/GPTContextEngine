; Context Engine Demo by CUrtis White for Powershell & Command Prompt
; Purpose: This script allows you to use GPT-4 to translate natural language into PowerShell or Command prompt and to demonstrate power of a dynamic context
; engine, i.e universal translate.

; Performance and warning settings
#NoEnv  ; Recommended for performance
#Warn   ; Enable warnings

; Setting the SendMode to Input for faster and more reliable sending of keystrokes
SendMode Input

; Only allow one instance of this script to run
#SingleInstance force

; Include the JSON library (Make sure JSON.ahk is in the same directory)
#Include %A_ScriptDir%\JSON.ahk

; Load the API key from a text file
; FileRead, apiKey, %A_ScriptDir%\GPT_API_KEY.txt

global apiKey = ""
global context = ""
global vMyEdit
global context := ""
global contextVerbose := ""

; Bind the Ctrl+J key to reload the script (useful for development)
Hotkey, ^j, Reloader, On

; Store the active window ID
WinGet, active_id, ID, A

; Bind the Ctrl+J key to reload the script (useful for development)
Hotkey, ^j, Reloader, On

; Bind the Ctrl+Space key to show the GUI
^Space::  ; The hotkey Ctrl+Space
    ; Get the unique ID (HWND) of the active window for later use
    active_id := WinActive("A")

    ; Get the title of the active window
    WinGetTitle, active_title, ahk_id %active_id%

    ; Identify the active window to determine the context
    if (InStr(active_title, "Command Prompt"))
    {
        guiTitle := "Command Prompt Translate Context"
        context := "Context is Windows Command."
        contextVerbose  := "Translate the user's request into Windows Command Prompt and nothing else."
        DisplayGui(guiTitle)

    }
    else if (InStr(active_title, "PowerShell"))
    {

        guiTitle := "PowerShell Translate Context"
        context := "Context is PowerShell."
        contextVerbose  := "Translate the user's request into Powershell command and nothing else."
        DisplayGui(guiTitle)
    }

return

DisplayGui(guiTitle)
{
    ; Destroy any existing GUI to avoid conflicts
    Gui, Destroy

    ; Create a new GUI with an Edit control
    Gui, New
    Gui, Add, Edit, w300 h20 vMyEdit, Enter your text here
    Gui, Add, Button, gSubmit Default, Submit

    ; Show the GUI in the center with the context-aware title
    Gui, Show, Center, %guiTitle%
}
Submit:
    ; Fetch the text from the Edit control
    Gui, Submit, NoHide
    InputText := MyEdit

     context := context . contextVerbose
    ; add context
    contextualized := InputText

    ; Escape the string for JSON compliance
    escaped := JSON.Dump(contextualized)

    apiResponse := GptRequest(escaped)

    ; Activate the original window using its unique ID
    WinActivate, ahk_id %active_id%

    ; Paste the text into the active window
    clipboard := apiResponse
    SendInput, {Ctrl Down}v{Ctrl Up}

    ; Destroy the GUI
    Gui, Destroy
return

Reloader:
    ToolTip, Script Reloading
    Sleep, 800  ; Display the tooltip for 2 seconds
    Reload
    ToolTip  ; Remove the tooltip
return


; Function to make the API call
GptRequest(prompt)
{
    ; Initialize the HTTP request
    WinHTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
    WinHTTP.Open("POST", "http://localhost:8766/v1/chat/completions")
    WinHTTP.SetRequestHeader("Content-Type", "application/json")
    WinHTTP.SetRequestHeader("Authorization", "Bearer " . apiKey)  ; Make sure apiKey is globally accessible

    ; API parameters
    model := "gpt-4"  ; Model name
    stream := "false" ; Streaming disabled
    newChat := "true" ; Start a new chat

    ; Construct the JSON payload
    jsonRequest := "{""messages"": [ {""role"": ""system"", ""content"": """ . context . """}, {""role"": ""user"", ""content"": " . prompt . "} ], ""model"": """ . model . """, ""stream"": " . stream . ", ""newChat"": " . newChat . "}"

    ; Send the API request
    WinHTTP.Send(jsonRequest)
    WinHTTP.WaitForResponse()

    ; Get the API response and parse it
    response := WinHTTP.ResponseText

    ; Check if the request was successful
    if (WinHTTP.Status != 200)
    {
        MsgBox, % "API call failed with status: " . WinHTTP.Status
        return ""
    }

    jsonResponse := JSON.Load(response)
    responseText := jsonResponse.choices[1].message.content

    ; Basic error check
    if (responseText = "")
    {
        MsgBox, API response format not as expected.
        return ""
    }

    ; Return the extracted message content
    return responseText
}
