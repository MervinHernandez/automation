# Mervin's Automations
Repository where I write down all the automations, scripts, shortcuts, and otherwise handy things used throughout my workstation.

Below, I'm gonna write down stuff that is active, WIP, and desired scripts.

# Devices
## Household - Kasa (TP Link)
| Device Name | MAC Address |
| --- | --- |
| Kasa - Victor | CC:32:E5:22:FC:8C |
| Kasa - Whiskey | D8:0D:17:46:E6:23 |
| Kasa - Zulu | D8:0D:17:46:B5:74 |
| Kasa - Alpha (PC’s) | 0C:80:63:0B:6C:79 |

## IFTT
Webhook Events via Maker Key `dqAVO2Ni3N6WTTMcsp6A_M`

| Event Name | Description | 
| ---      |  ------  |
| KASA Tango | Merv iPhone > Kasa App > Toggles the "Tango" smart plug | 
| KASA Uniform | Merv iPhone > Kasa App > Toggles the "Uniform" smart plug | 
| KASA Zulu | Merv iPhone > Kasa App > Toggles the "Zulu" smart plug | 

> Example of a full URL for a script trigger is
> 
> `https://maker.ifttt.com/trigger/kasa_uniform/with/key/dqAVO2Ni3N6WTTMcsp6A_M`


# Web Dev
## TEST Gravity Form
`web_dev/gravity_form_test.ahk`
1. Grab form fields from spreadsheet
2. Tab thru and fill-in all values into a browser view Gravity Form
3. Rinse and repeat

## Gravity Form Fields to Custom Post Type CPT Meta
`web_dev/workflow_gf_to_cpt.ahk`
1. With a spreadsheet source list of the `meta_key` values desired, this script helps populate these meta keys onto the respective "custom field" parameters in a given GF field.

# 📜 Zapier
## [WIP] Slack Status - Auto Update
1. Depending on my "MASTER" calendar, then update the Slack workspaces for my Work (rtCamp) and WingManWP respectively.

# 📜 AutoHotkey Scripts
## Workflow - VNC Shortcuts
`workflows/vnc_shortcuts.ahk`
1. Generates a GUI window with shortcuts to VNC destinations I use often

## [WIP] Alpha - Start Sequence
To start my day.
1. Open Outlook + position outlook windows
2. Open 7x Windows Task View Desktops
3. Open Chrome profiles + position chrome windows in various Windows Desktops
4. Open vMix + position vMix on second monitor

## Workflow - Accounting - Save Receipt
`workflows/accounting_save_receipt.ahk`
1. Ask for the vendor
2. Ask for the date of the receipt
3. Ask for the amount of the receipt
4. Save the file name to the clipboard, for use when saving the PDF receipt in view

## [WIP] Select "Area of Life"
`autohotkey/helpers/select_gtd_area.ahk` 
1. Create nested dropdown list window
2. Populate these nested dropdown lists with GTD "Areas of Life" lists

## [WIP] FIND Latest Downloaded File
`autohotkey/helpers/latest_file.ahk`
1. Get path for latest file in Downloads folder (C:\Users\mervi\Downloads)

## [WIP] Startup Sequence
1. Start Outlook + position on screens
2. Start vMix + position on screens
3. Start Chrome + position on screens

## [WIP] Outlook - Export Calendar to CSV
`workflows/outlook_export_calendar.ahk`
1. Navigate thru all the menu options to spit out a CSV of my calendar.

## [WIP] Outlook - Appointment - Flyout Menu
`workflows/outlook_appt_flyout.ahk`
1. Generate a "sticky" flyout menu next to an appointment window
2. Offer up shortcuts to naming contentions, details to be added, etc.
## [WIP] Outlook - Select TimeZone
`autohotkey/helpers/outlook_select_timezone.ahk`   
Quickly select timezones, instead of having to view and scroll to a certain selection on a long dropdown list.

## Outlook - Start
`autohotkey/start_things/outlook.ahk`
1. Open Outlook
2. Open Calendar Window
3. Position these windows
4. Open other calendars
5. Focus on `MASTER` calendar

## Outlook - Manipulate Appointment Saving
`autohotkey/helpers/outlook_app_remind0.ahk`
* Set appointment reminder to 0 minutes
`autohotkey/helpers/outlook_app_remind5.ahk`
* Set appointment reminder to 5 minutes
`autohotkey/helpers/outlook_app_remind10.ahk`
* Set appointment reminder to 10 minutes
`autohotkey/helpers/outlook_app_save_rtc.ahk`
* Set appointment to be saved in the "rtCamp" calendar
`autohotkey/helpers/outlook_app_save_wingman.ahk`
* Set appointment to be saved in the "WingMan WP" calendar

# [WIP] vMix
`autohotkey/start_things/vmix.ahk`
1. Open vMix
2. Wait for vMix to initiate
3. Move vMix to second monitor

## [WIP] Windows - Manipulate Task Views
`autohotkey/start_things/win_desktops_close.ahk`
`autohotkey/start_things/win_desktops_open.ahk`
1. Open/Close "ALL" desktop task views

## Window - View Window on All Desktops
`autohotkey/helpers/do_screen2_allmon.ahk`
`autohotkey/helpers/do_screen3_allmon.ahk`
1. Make window presently in focus visible on all "task view" desktops.

## Window - Hide from Alt-Tab
`autohotkey/helpers/window_hide_alttab.ahk`
1. Hide window presently in focus from appearing in Alt-Tab menu.

## Chrome - Control Xfinity Screen
`autohotkey/helpers/mute_xfinity.ahk`
`autohotkey/helpers/mute_xfinity_hi.ahk`
`autohotkey/helpers/mute_xfinity_low.ahk`
1. Focus in Xfinity window
2. Adjust volume control

## Chrome - Start Things
`autohotkey/start_things/chrome_all.ahk`
* Start all needed Chrome profiles
`autohotkey/start_things/chrome_all_move.ahk`
* Move chrome windows to respective Windows Task View Desktop Locations
`autohotkey/start_things/chrome_rtc.ahk`
* Start a window of my `Chrome > rtCamp` profile
`autohotkey/start_things/chrome_wing.ahk`
* Start a window of my `Chrome > WingManWP` profile
`autohotkey/start_things/chrome_app_youtube.ahk`
* Start the Google Chrome App `YouTube`
`autohotkey/start_things/chrome_app_xfinity.ahk`
* Start the Google Chrome App `Xfinity`

# 📜 iOS Shortcuts
## Start the Washer
1. Ask how long the load will run for
2. Create calendar event in the `Household` calendar for this
3. Create calendar event in the `MASTER` calendar with reminder for me to swap the load 
## Start the Dryer
1. Ask how long the dryer will run for
2. Create calendar event in the `Household` calendar for this
3. Create calendar event in the `MASTER` calendar with reminder for me to take out the laundry
