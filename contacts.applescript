-- steps:
--   1. pull all contacts from contacts application
--   2. extract each contact's full name and phone number
--   3. write new list to backup contacts

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
            set end of contactList to counter & ". " & contactName & ": " & phoneNumber & return
            set counter to counter + 1 -- increment numlist
        end repeat
    end repeat
end tell

-- turn list into string with line breaks
set contactString to contactList as string

-- 3. write new list to backup contacts
tell application "Notes"
    set theFolder to "Contacts"
    set newNote to make new note at folder theFolder with properties {name:"BACKUP CONTACTS 9", body:contactString}
end tell
