function calcAvailableSpace
    set SIZE (math -s1 (string match --regex "[0-9\.]*" $argv[1]))
    set USED (math -s1 (string match --regex "[0-9\.]*" $argv[2]))
    set FREE (math -s1 $SIZE - $USED )
    set PERC (math -s0 $USED / $SIZE \* 100)

    echo {$SIZE}G {$USED}G {$FREE}G {$PERC}%
    #    functions -e calcAvailableSpace
end

function dfa -w 'df -h --output=source,fstype,size,used,avail,pcent,target -x tmpfs -x devtmpfs' -d 'Shows disk space including btrfs using btrfs functions'
#function dfa
    set FILESYSTEMS (df -h --output=source,fstype,size,used,avail,pcent,target -x tmpfs -x devtmpfs | tail -n +2 | sed "s/ \+/ /g" | sort )
    for FS in $FILESYSTEMS
        set FSA (string split -n -m 6 " " $FS)
        if test "$FSA[2]" = "btrfs"
            set BTRFS (sudo btrfs fi show --gbytes $FSA[7] | sed -n "/devid/s/ \+/ /gp" | string split -n " ")
            set BTRSIZE (calcAvailableSpace $BTRFS[4] $BTRFS[6] | string split " ")
            set FSA[3..6] $BTRSIZE[1..4]
        end
        set NEWFSS $NEWFSS "$FSA"
    end
    set foutput (printf ' %-11s:%-6s:%6s:%6s:%6s:%5s:%s' Filesystem Type Size Used Avail Use% "Mounted on" )'\n'
    for FS in $NEWFSS
        set foutput $foutput (printf '%-11s:%-6s:%6s:%6s:%6s:%5s:%s' (string split -m6 " " $FS))'\n'
    end
    echo -e $foutput | column -t -s ":" -o ' '
end
