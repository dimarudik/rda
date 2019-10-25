find $ORACLE_BASE/diag/rdbms/${ORACLE_SID,,}_n/$ORACLE_SID/trace/ -maxdepth 1 -type f -name "*HAD*.trc" -mmin -80 | xargs grep "dump location:" | awk '{print ($4)}' | uniq
sed -n '/XCTEND.*32011705617666/,/XCTEND.*32011729496779/p' SIEBEL_ora_107197.trc > ttt.out
| awk 'BEGIN{a=0}{a+=$1}END{print a}'
