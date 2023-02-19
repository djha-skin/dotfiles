himalaya --disable-cache -o json -a gmail folders list `
    | jq -r '.[].name' `
    | where-object  { $_ -notin @(
    "[Gmail]All Mail"
    "[Gmail]Chats",
    "[Gmail]Spam") } | foreach-object {
    himalaya -a gmail -f "${_}" accounts sync
}
