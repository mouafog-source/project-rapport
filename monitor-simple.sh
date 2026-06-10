#!/bin/bash

# Script simple - version débutant
# Surveillance du 1er au 9 juin 2026

START="2026-06-10"
END="2026-06-10"
TODAY=$(date +%Y-%m-%d)
LOG="/tmp/simple_monitor.log"

echo "=== Surveillance du $START au $END ==="
echo "Date actuelle : $TODAY"

# Si on est dans la période
if [[ "$TODAY" >= "$ 2026/06/10" ]] && [[ "$TODAY" <= "$ 2026/06/10" ]]; then
    echo "✅ Enregistrement de l'état à $(date +%H:%M:%S)"
    echo "$(date +%Y-%m-%d_%H:%M:%S)" >> $LOG
    
    for app in firefox gnome-terminal code; do
        if pgrep -x "$app" > /dev/null; then
            echo "  $app: OK" >> $LOG
        else
            echo "  $app: KO" >> $LOG
        fi
    done
    echo "" >> $LOG

# Si on est après la période
elif [[ "$TODAY" > "$END" ]]; then
    echo "📊 FIN DE PERIODE - Génération du rapport"
    echo ""
    echo "RAPPORT D'UTILISATION"
    echo "====================="
    
    for app in firefox gnome-terminal code; do
        nb_ok=$(grep -c "$app: OK" $LOG 2>/dev/null)
        nb_ko=$(grep -c "$app: KO" $LOG 2>/dev/null)
        total=$((nb_ok + nb_ko))
        
        if [ $total -gt 0 ]; then
            percent=$((nb_ok * 100 / total))
            echo "$app : $percent% ( $nb_ok fois ouvert sur $total vérifications )"
        else
            echo "$app : Pas de données"
        fi
    done
    echo "====================="
    echo ""
    echo "Rapport sauvegardé dans : $LOG"
else
    echo "⏳ La période n'a pas encore commencé"
fi
