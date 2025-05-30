@echo on

pandoc -f commonmark-raw_html+pipe_tables+task_lists+emoji -t pdf ^
    --pdf-engine=xelatex ^
    -V sansfont:Arial ^
    -V mainfont:Arial ^
    -V monofont:Consolas ^
    -V colorlinks:true ^
    -V fontsize:12pt ^
    -V geometry:margin=1in ^
    %~1 ^
    -o %~2