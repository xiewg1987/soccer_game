**WARNING:** Depends on [**Gopilot Utils**](https://gitlab.com/Marty_Friedrich/gopilot-utils) ⚠️  
Requires Godot 4.4 to function! ⚠️

# AI-autocomplete and chat in Godot ✨
***Gopilot Assist*** can assist you in **many small tasks**:
- **autocomplete** your code 👩‍💻
- **provide help** for **your scripts** in the chat 🖹
- **create parts** of your scene tree and scripts 🛠️
- **refactor code** with your lead 👩‍🏫
- **whatever you want** (via `GopilotTool`) 🤯

It focusses on **token-efficiency** and **customizability**

## Chat
![image of chat interface](screenshots/chat_interface.png)

The chat is great for ideating on your code or gameplay concepts.

**When prompted**, Gopilot can look at:
- your scene tree (`@scene`)
- your project files (`@files(<folder depth e.g. 7>)`)
- your scripts (`@script` for current script or `@my_script.gd` for other open scripts)
- the docs (`@docs(<NameOfNodeClass>)`)
- your selected code (automatic)

To **remove these retrieval methods**, disable the check in the **top right**

## AI-autocomplete
![image of ai-autocomplete in action](screenshots/autocomplete.png)

In the shown example, the `_ready()` **method was generated** based on the code above

Many LLMs are largely **trained on Godot 3**.  
In the example it generated **outdated Godot 3 signal syntax** ⚠️

## Gopilot Agent
Can't be bothered to **make a login screen?**

Count yourself lucky, because **Gopilot Agent** *might* just do that for you:

![video of Gopilot Agent creating a login and register screen](screenshots/agent_creates_login.mp4)

Gopilot Agent can:
- **Add**, **edit** and **remove** **Nodes**
- **create**, **store** and **assign** **Scripts**
- create **user interfaces**

... And _all that_ with **automatic error-retrieval** in an agentic approach

## Customizability
### Settings
![image of the settings menu](screenshots/settings.png)

Want to change the **chat behaviour**? Reduce token consumption with **autocomplete**? Maybe **disable that big godot logo**?

The settings menu lets you customize all that - **and more**!

### Custom APIs
Your API provider is **not in the list**?

Add your own **custom API provider** under _`res://addons/gopilot_utils/api_providers`_!

_**Still too much work?**_

Open a pull request on [**Gopilot Utils**](https://gitlab.com/Marty_Friedrich/gopilot-utils) to support your favourite API provider.

### GopilotBuddy
![image of gopilot buddy creator](screenshots/buddy_creation.png)

Default system prompt too _standard_ or **token-heavy**?

Create your own GopilotBuddy with **custom system prompt** and **temperature**!

### Custom Tools and Agents

![image of tool interfaces in the chat](screenshots/custom_tool_ui.png)

[**Gopilot Utils**](https://gitlab.com/Marty_Friedrich/gopilot-utils) recently added the `AgentHandler` and it's already used in **Gopilot Assist**!

By default, you can select between **"Chat"** and **"Agent"** in the chat.

But... what if you want to **make your own tool or agent**? Or your **own retrieval tool**?

Gopilot allows you to create **fully custom** tools!

Browse _`res://addons/gopilot_assist/tools`_ and take a look at _`gopilot_example_tool/tool.tscn`_ to **see it work!**

You can make full use of [**Gopilot Utils**](https://gitlab.com/Marty_Friedrich/gopilot-utils) and create **retrieval tools**, **workflow-based tools** or full **autonomous agents**!

`GopilotTool`s allow you to seamlessly add **custom UI elements into the chat!**

# Roadmap 🚌

_**Gopilot Assist**_ is already _mostly usable_ and **feature-rich**.  
_But what if_ - it were **2x as cool?** 😎

Here are the **main points I want to accomplish** 👷‍♀️

- ### Improve chat-customizability 🛠️
  - Turn **`GopilotBuddy`** from `Resource` to `Node`
  - Fully **custom chat-bubble-handling** for **`GopilotTool`** and **`GopilotBuddy`**
- ### Expand settings ⚙️
  - Add ability to **add**, **edit** and **remove** *refactor prompts*
  - Add **more API providers** in [**Gopilot Utils**](https://gitlab.com/Marty_Friedrich/gopilot-utils) and **improve existing ones**
- ### Strengthen _Gopilot Agent_ 🤵‍♀️
  - Improve **reliability**
    - Add **loop-handling**
    - **decrease** tools per agent, **increase** agent count
  - **Add token- and request-count-efficient mode** 💸
  - Increase user feedback for **intermediate steps**
- ### Improve Chat 🗨️
  - Refine **prompt recommendations** to **include retrieval tools**
  - Allow **regenerating**, **editing** and **removing** of messages 🪛
- ### Reducing errors (_obviously_) 😒
  - _**Gopilot Agent**_
    - Fix scene root duplication error
    - Always get correct scene root, even if scene is not saved

### Difficult or impossible goals 🏔️
- Perfect error handling for _**Gopilot Agent**_
  - Script error retrieval impossible
- Chat **history storage**
  - Storing tool-based UI elements is exhausting for tool devs
- Improved multi-line autocomplete
  - rules for _fill-in-the-middle code-gen_ are complex...
- LLM based tool decision
  - Want to keep request count and model size low
  - Might be easier with refactored **`GopilotBuddy`** and **chat interface**