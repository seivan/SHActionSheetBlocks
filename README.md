Check the console for referenced sheet.
Once dismissed, MAP NSMapTable should be empty (check console)

in SHViewController:L60, get rid of sheet = nil, and run the application again.
This time after dismissing the sheet, it's still referenced, by what I suspect to be self.view.


