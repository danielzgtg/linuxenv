# Enable CTRL-Arrow
# Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Chord Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Ctrl+RightArrow -Function ForwardWord
