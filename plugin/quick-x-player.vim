fu! RunPlayer()
    exe system("source ~/.zshrc")

    let s:workDir = getcwd()
    let s:file = "scripts/main.lua"
    let s:width = str2nr(system("sed -n '/CONFIG_SCREEN_WIDTH/p' config.lua | awk 'NR==1 {print $3}'"))
    let s:height = str2nr(system("sed -n '/CONFIG_SCREEN_HEIGHT/p' config.lua | awk 'NR==1 {print $3}'"))

    if !exists("$QUICK_COCOS2DX_ROOT")
        echohl WarningMsg | echo "Please make sure launch vim from \
        terminal.\nDid you set QUICK_COCOS2DX_ROOT in your .bashrc or .zshrc?\n" | echohl None

        return
    endif

    let s:appName = "player"
    let s:args = "-workdir ".s:workDir."/../"." -file ".s:file." -size ".s:width."x".s:height." -disable-write-debug-log"
    let s:customed_player = s:workDir."/.."."/proj.player/".s:appName.".app/Contents/MacOS/".s:appName
    let s:quick_player_path =$QUICK_COCOS2DX_ROOT."/player/mac/".s:appName.".app/Contents/MacOS/".s:appName
    let g:tips = ""
    if executable(s:customed_player)
        let g:tips = "Run with customed player."
        silent! execute join(["!","nohup ",s:customed_player,s:args," >/dev/null &"]," ")
    elseif executable(s:quick_player_path)
        let g:tips = "Run with default player."
        silent! execute join(["!","nohup ",s:quick_player_path,s:args," >/dev/null &"]," ")
    else
        echohl WarningMsg | echo "err : cant find any app of player\n" | echohl NONE
    endif
    echo g:tips
endf
command! RunPlayer call RunPlayer()

fu! CompileScripts()
    " let scriptPath = join(getcwd()
endf
command! CompileScripts call CompileScripts()

" fu! LoadLuafiles()
    " let s:workDir = getcwd()
    " let s:quick_scripts_pathName = "scripts"
    " let s:pathLen = strlen(s:workDir)
    " let s:partLen = strlen(s:quick_scripts_pathName)
    " if  s:pathLen > s:partLen
        " if strpart(s:workDir,s:pathLen-s:partLen,s:partLen) == s:quick_scripts_pathName
            " :args**/*.lua
            " return
        " endif
    " endif

    " echohl WarningMsg | echo printf("load lua files failed ,\
    " please make sure your current working dir is **/**/**/%s",s:quick_scripts_pathName)
    " | echohl NONE
" endf
" command! LoadLuafiles call LoadLuafiles()

fu! LoadQuickXFrameworkInNewWindow()
    let s:cmd = "!cd $QUICK_COCOS2DX_ROOT/framework && find . -name '*.lua' | xargs mvim"
    silent! exe s:cmd
endf
command! LoadFrameWork call LoadQuickXFrameworkInNewWindow()

fu! Create_class(name)
    let s:template = "local ".a:name." = class(\"".a:name."\")\n\nfunction ".a:name.":ctor()\n\nend\n\nreturn ".a:name
    normal diw
    let @* = s:template
    silent! normal "*p
endf
command! CreateClassWithName call Create_class(expand("<cword>"))

fu! Create_function(funcName)
    let s:fileName = matchstr(expand("%:t"),"[^\.]*") 
    let s:template = "function ".s:fileName.":".a:funcName."()\n\nend"
    normal diw
    let @* = s:template
    silent! normal "*p
endf
command! CreateFunctionWithName call Create_function(expand("<cword>"))

fu! View_debugLog()
    let s:workDir = getcwd()
    let s:cmd1 = ":vnew"
    silent! exe s:cmd1
    let s:cmd2 = ":r!cat ".s:workDir."/.."."/debug.log"
    silent! exe s:cmd2
endf
command! ViewDebugLog call View_debugLog()

nnoremap <Leader>vdl :ViewDebugLog<CR>
norema  <D-F2>      :RunPlayer<CR>
" noremap  <Leader>ll  :LoadLuafiles<CR>
noremap  <Leader>ll  :args**/*.lua<CR>
noremap  <Leader>lf  :LoadFrameWork<CR>
vnoremap <Leader>gg  YGPifunction <ESC>wwr:wdwdwyeiget<ESC>l~wc$()<CR><ESC>iend<ESC>O<ESC>"0pIreturn <ESC>A_<ESC>biself.<ESC>

