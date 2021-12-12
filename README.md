# Mervin's Automations
Repository where I write down all the automations, scripts, shortcuts, and otherwise handy things used throughout my workstation.

Below, I'm gonna write down stuff that is active, WIP, and desired scripts.

# Web Dev
## TEST Gravity Form
`web_dev/gravity_form_test.ahk`
1. Grab form fields from spreadsheet
2. Tab thru and fill-in all values into a browser view Gravity Form
3. Rinse and repeat

# 📜 Zapier
## [WIP] Slack Status - Auto Update
1. Depending on my "MASTER" calendar, then update the Slack workspaces for my Work (rtCamp) and WingManWP respectively.

# 📜 AutoHotkey Scripts
## [WIP] Alpha - Start Sequence
To start my day.
1. Open Outlook + position outlook windows
2. Open 7x Windows Task View Desktops
3. Open Chrome profiles + position chrome windows in various Windows Desktops
4. Open vMix + position vMix on second monitor

## [WIP] Select "Area of Life"
`inc/helpers/select_gtd_area.ahk` 
1. Create nested dropdown list window
2. Populate these nested dropdown lists with GTD "Areas of Life" lists

## [WIP] FIND Latest Downloaded File
`inc/helpers/latest_file.ahk`
1. Get path for latest file in Downloads folder (C:\Users\mervi\Downloads)

## [WIP] Startup Sequence
1. Start Outlook + position on screens
2. Start vMix + position on screens
3. Start Chrome + position on screens

## [WIP] Outlook - New Appointment Shortcuts
* Upon opening the "new appointment" window, there is a flyout menu (GUI) that is sticky with the window
* This sticky menu offers "Personal / Work / Household / Community Projects" related shortcuts for appointment templates

## Outlook - Start
`inc/start_things/outlook.ahk`
1. Open Outlook
2. Open Calendar Window
3. Position these windows
4. Open other calendars
5. Focus on `MASTER` calendar

## Outlook - Manipulate Appointment Saving
`inc/helpers/outlook_app_remind0.ahk`
* Set appointment reminder to 0 minutes
`inc/helpers/outlook_app_remind5.ahk`
* Set appointment reminder to 5 minutes
`inc/helpers/outlook_app_remind10.ahk`
* Set appointment reminder to 10 minutes
`inc/helpers/outlook_app_save_rtc.ahk`
* Set appointment to be saved in the "rtCamp" calendar
`inc/helpers/outlook_app_save_wingman.ahk`
* Set appointment to be saved in the "WingMan WP" calendar

# [WIP] vMix
`inc/start_things/vmix.ahk`
1. Open vMix
2. Wait for vMix to initiate
3. Move vMix to second monitor

## [WIP] Windows - Manipulate Task Views
`inc/start_things/win_desktops_close.ahk`
`inc/start_things/win_desktops_open.ahk`
1. Open/Close "ALL" desktop task views

## Window - View Window on All Desktops
`inc/helpers/do_screen2_allmon.ahk`
`inc/helpers/do_screen3_allmon.ahk`
1. Make window presently in focus visible on all "task view" desktops.

## Window - Hide from Alt-Tab
`inc/helpers/window_hide_alttab.ahk`
1. Hide window presently in focus from appearing in Alt-Tab menu.

## Chrome - Control Xfinity Screen
`inc/helpers/mute_xfinity.ahk`
`inc/helpers/mute_xfinity_hi.ahk`
`inc/helpers/mute_xfinity_low.ahk`
1. Focus in Xfinity window
2. Adjust volume control

## Chrome - Start Things
`inc/start_things/chrome_all.ahk`
* Start all needed Chrome profiles
`inc/start_things/chrome_all_move.ahk`
* Move chrome windows to respective Windows Task View Desktop Locations
`inc/start_things/chrome_rtc.ahk`
* Start a window of my `Chrome > rtCamp` profile
`inc/start_things/chrome_wing.ahk`
* Start a window of my `Chrome > WingManWP` profile
`inc/start_things/chrome_app_youtube.ahk`
* Start the Google Chrome App `YouTube`
`inc/start_things/chrome_app_xfinity.ahk`
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
