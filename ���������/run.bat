set path=%path%;"%ProgramFiles%\MiKTeX 2.7\miktex\bin\"
del /q task2.pdf
dvipdfm  task2.dvi
pause
