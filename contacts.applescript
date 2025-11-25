-- steps:
--   1. pull all contacts from contacts application
--   2. extract each contact's full name and phone number
--   3. write new list to backup contacts
------------------------------------------------------------

-- 1. pull all contacts from contacts application
tell application "Contacts"
    set contactList to {}
    set allContacts to every person
    set counter to 1 -- for numlist
    
    repeat with aContact in allContacts
        set contactName to name of aContact
        set phoneNumbers to phone of aContact
        repeat with aPhone in phoneNumbers
            set phoneNumber to value of aPhone
            -- 2. extract each contact's full name and phone number
            -- format: "1. full name: phone number"
            set end of contactList to counter & ". " & contactName & ": " & phoneNumber
            set counter to counter + 1 -- increment numlist
        end repeat
    end repeat
end tell

-- convert list to string with proper line breaks
-- HTML force line breaks
set contactHTML to "<html><body>"
repeat with c in contactList
    set contactHTML to contactHTML & c & "<br>"
end repeat
set contactHTML to contactHTML & "</body></html>"

-- 3. write new list to backup contacts
tell application "Notes"
    set theFolder to folder "Contacts"
    set newNote to make new note at theFolder with properties {name:"BACKUP CONTACTS 9", body:contactHTML}
end tell
