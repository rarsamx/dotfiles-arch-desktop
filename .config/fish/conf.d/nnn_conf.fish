#!/usr/bin/env fish

# Environment variables used by the nnn file manager
set -gx NNN_PLUG    "d:dragdrop;f:diffs;i:imgview;m:nmount-udisk;t:treeview;p:preview-tabbed"
set -gx NNN_ARCHIVE "\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)\$"
set -gx NNN_TRASH   1
set -gx NNN_BMS     "s:~/Documents/Papa/Statements;l:~/Documents/Papa/Languages"
set -gx NNN_FIFO    "/tmp/nnn.fifo"
set -gx NNN_COLORS  "2356"
