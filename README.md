Here are ports of scripts I've written into lua.

1. Touchpad enabled/disabled - for xorg with use of xinit. When/if ever I make the switch to wayland I'll configure with libinput.
2. helpers, where I store a module with commonly used methods throughout these scripts/programs.
3. spellmaker - to quickly make/port a script


Password Manager (written in lua):

    1. Dependencies:
        1. rofi
        2. VictorMono font:
            1. *Note:* If you do not wish to install rofi or VictorMono, you can modify the source code (replace rofi with another lister -i.e 'dmenu', and font of your choice)
        3. Environment Variable named "PASS", which is an absolute path to a password file
        4. All programs in your password file must end with "_"

TODO:
    1. make a variable for font and lister so it's easier to swap out to a program and font of your choosing
    2. introduce an encryption step for the $PASS variable
