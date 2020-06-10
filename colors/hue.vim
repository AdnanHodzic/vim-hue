"%% Hue Vim color file
" Hue Maintainer: Adnan Hodzic <adnan@hodzic.org>
" (based on Slate color scheme by Ralph Amissah <ralph@amissah.com>)
:set background=dark
:highlight clear
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif
let colors_name = "hue"
:hi Normal guifg=White guibg=grey35
:hi Cursor guibg=khaki guifg=slategrey
:hi CursorLine ctermfg=NONE ctermbg=16 cterm=NONE guifg=NONE guibg=#373b3c gui=NONE
:hi VertSplit guibg=#c2bfa5 guifg=grey40 gui=none cterm=reverse
:hi Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey
:hi FoldColumn guibg=black guifg=grey20 ctermfg=4 ctermbg=7
:hi IncSearch guifg=green guibg=black cterm=none ctermfg=yellow ctermbg=green
:hi ModeMsg guifg=goldenrod cterm=none ctermfg=brown
:hi MoreMsg guifg=SeaGreen ctermfg=darkgreen
:hi NonText guifg=RoyalBlue guibg=grey15 cterm=bold ctermfg=blue
:hi Question guifg=springgreen ctermfg=green
:hi Search ctermfg=red ctermbg=yellow guifg=black
:hi SpecialKey guifg=yellowgreen ctermfg=darkgreen
:hi StatusLine ctermbg=black ctermfg=cyan cterm=bold,reverse
:hi StatusLineNC ctermbg=black ctermfg=cyan
:hi Title guifg=gold gui=bold cterm=bold ctermfg=yellow
:hi Statement guifg=CornflowerBlue ctermfg=lightblue
:hi Visual ctermfg=NONE ctermbg=57 cterm=NONE guifg=NONE guibg=#2E3436 gui=NONE
:hi WarningMsg guifg=salmon ctermfg=1
:hi String guifg=LightBlue ctermfg=blue
:hi Comment term=bold ctermfg=10 guifg=grey50
:hi Constant guifg=#ffa0a0 ctermfg=yellow
:hi Special guifg=darkkhaki ctermfg=blue
:hi Identifier guifg=salmon ctermfg=red
:hi Include guifg=red ctermfg=red
:hi PreProc guifg=red guibg=white ctermfg=red
:hi Operator guifg=Red ctermfg=Red
:hi Define guifg=gold gui=bold ctermfg=yellow
:hi Type guifg=CornflowerBlue ctermfg=2
:hi Function guifg=navajowhite ctermfg=lightblue
:hi MatchParen cterm=none ctermbg=red ctermfg=black
:hi Structure guifg=green ctermfg=green
:hi LineNr ctermfg=172 guifg=Grey guibg=Grey90
:hi Ignore guifg=grey40 cterm=bold ctermfg=7
:hi Todo guifg=orangered guibg=yellow2
:hi Directory ctermfg=darkcyan
:hi ErrorMsg cterm=bold guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
:hi VisualNOS cterm=bold,underline
:hi WildMenu ctermfg=0 ctermbg=3
:hi DiffAdd ctermbg=4
:hi DiffChange ctermbg=5
:hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
:hi DiffText cterm=bold ctermbg=1
:hi Underlined cterm=underline ctermfg=5
:hi Error guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
:hi SpellErrors guifg=White guibg=Red cterm=bold ctermfg=7 ctermbg=1
":hi String ctermfg=161 ctermbg=none
:hi String ctermfg=86 ctermbg=none
