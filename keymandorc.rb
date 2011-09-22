start_at_login(true)

def send_keys(keys)
   lambda{send(keys)}
end
def lock_the_screen
  lambda{lock_screen}
end
def display_message(message)
  lambda{alert(message)}
end
def reload_configuration
  lambda{ growl("Configuration reloaded successfully") if reload}
end

# ViKing can ignore entire applications
disable "Remote Desktop Connection"
disable /VirtualBox/

# Enable/disable ViKing
toggle "<Ctrl-E>"

# Basic mapping
nmap "<Ctrl-[>", "<Escape>"
map "<Ctrl-m>", "<Ctrl-F2>"

# Lets disable those pesky arrows 
# in a couple different ways.
# map "<Up>", nil
# map "<Down>", noop
# %w(<Left> <Right>).each { |k| map k, nil }

# The following mappings are valid 
# except for these application(s)
except /iTerm/, "MacVim" do
  map "<Ctrl-j>", "<Down>"
  map "<Ctrl-k>", "<Up>"
  map "<Ctrl-h>", "<Left>"
  map "<Ctrl-l>", "<Right>"
  map "<Ctrl-f>", "<PageUp>"
  map "<Ctrl-b>", "<PageDown>"

  map "<Ctrl-Shift-j>", "<Shift-Down>"
  map "<Ctrl-Shift-k>", "<Shift-Up>"
  map "<Ctrl-Shift-h>", "<Shift-Left>"
  map "<Ctrl-Shift-l>", "<Shift-Right>"

  # Right mouse click
  map "<Ctrl-r>" { right_click }

end

# Disable quiting for iTerm.  Should only exit via command line
only /iTerm/ do
  map "<Cmd-w>", nil
  map "<Cmd-q>", nil
  map "<Cmd-r>", nil
  map "<Cmd-t>", nil
end

# The following mappings are only valid for
# the given application(s)
only /Chrome/ do
  map "<Ctrl-h>", "<Cmd-{>"
  map "<Ctrl-l>", "<Cmd-}>"
  map "<Ctrl-u>", "<PageUp>"
  map "<Ctrl-d>", "<PageDown>"
end


# Reload .vikingrc
map "<Ctrl-R>" { reload }

# You can speak
map "<Ctrl-S>" { say "Hello, world." }

# Confirmations
map "<Cmd-Ctrl-l>" do  
  if confirm("Lock screen?") 
    say "Goodbye for now!"
    lock_screen 
  end
end

map "<Ctrl-T>" do  
  type(Time.now.strftime('%I:%M%p'))
end

# Blocks
map "<Ctrl-W>" do 
  alert("hello")
  alert("world")
end

# You can use uppercase or Shift
map "<Ctrl-Shift-q>" do 
  alert("hello")
  alert("world")
end


# Type out entire cords
# map "abc", type("alphabet")
# map "nname", type("Kevin Colyar")

# Application switching
map "<Cmd-p>" { application_previous }
map "<Cmd-n>" { application_next }

# map "<Cmd-n>" do 
#   input do |answer|
#     if answer == "screenshot"
#       send("<Cmd-Shift-3>") 
#       alert("Screenshot Taken!")
#     end
# 
#   end
#   # alert(input())
# end

#general_mnemonic_mappings
#----------------------------------------------------------------
map "<Cmd-y>" do 
  input(
    # This works and will be handy for nested mappings
    # "w" => lambda{
    #   input(
    #     "h" => lambda{send("<Ctre-5>")}, #send window top left
    #    )},
    #-----------------------------------------------------------
    #window_management
    #-----------------------------------------------------------
    "th" => send_keys("<Ctrl-1>"), #window_top_left
    "tl" => send_keys("<Ctrl-2>"), #window_top_right
    "bh" => send_keys("<Ctrl-3>"), #window_bottom_left
    "bl" => send_keys("<Ctrl-4>"), #window_bottom_right
    "h" => send_keys("<Ctrl-5>"), #window_left
    "j" => send_keys("<Ctrl-8>"), #window_top
    "k" => send_keys("<Ctrl-7>"), #window_bottom
    "l" => send_keys("<Ctrl-6>"), #window_right
    "f" => send_keys("<Ctrl-9>"), #window_full_screen
    "c" => send_keys("<Ctrl-0>"), #window_center
    #end_window_management---------------------------------------

    #-----------------------------------------------------------
    #general
    #-----------------------------------------------------------
    "rel" => reload_configuration,
    "ls" => lock_the_screen,
    "mi" => send_keys("<Cmd-Shift-U>"), #trigger_quicksilver_menu_items
    "x" => send_keys("<Cmd-q>"), #quit current application
    "screen" => send_keys("<Cmd-Shift-3>"),
    "qs" => send_keys("<Cmd- >"),
    "s" => lambda{say(prompt("Say Something"))},
    "spp" => send_keys("kevinc<Tab>#{Passwords[:sharepoint]}<Return>"),
    "rc" => lambda {
      activate("Google Chrome")
      sleep(1)
      send("<Cmd-r>")
      sleep(1)
      activate("iTerm")
    },
    "goo" => lambda {
      activate("Google Chrome")
      send("<Cmd-t>")
      send("<Cmd-l>")
    },

    "milk" => lambda {
       system("open https://www.rememberthemilk.com/home/kevin.colyar/")
    },

    "tma" => lambda {
      [
        'https://mail.google.com/mail/?shva=1#mbox', 
        'https://www.rememberthemilk.com/home/kevin.colyar/',
        'https://www.google.com/calendar/render?pli=1'
      ].each { |url| system("open #{url}") } 
    },

   "qt" => lambda{
        track = prompt("Enter track")
        send("<Cmd- >") 
        send("Browse Tracks")
        sleep(1)
        send("<Right>")
        sleep(1)
        send(track+'<Enter>')
    },
    "ba" => lambda {
        send("<Cmd- >") 
        send("Browse Artists")
        sleep(1)
        send("<Right>")
    },
    "bt" => lambda {
        send("<Cmd- >") 
        send("Browse Tracks")
        sleep(1)
        send("<Right>")
    },
    "g" => lambda{
      system("open http://google.com/search?q=\"#{prompt('Google')}\"")
    },
    "etm" => lambda {
      system('diskutil umount "/Volumes/Time Machine Backups"')
    }
    #end_general------------------------------------------------
    )

end
#end_general_mnemonic_mappings----------------------------------


#imap "<Cmd-t>" do
#  alert('Input Mode Only')
#end
#
#nmap "<Cmd-t>" do
#  alert('Normal Mode Only')
#end


only 'TextEdit' do 
  # map 'test', 'hello'
  # map 'c', 'cat'
  # map ':w', '<Cmd-s>'
  # map 'test', lambda { alert('haha')}
end

only /Chrome/ do
  map '<Ctrl-a>p', '<Cmd-{>'
  map '<Ctrl-a>n', '<Cmd-}>'
  map '<Ctrl-w>h', '<Cmd-{>'
  map '<Ctrl-w>l', '<Cmd-}>'
end

# map "<Cmd-l>", get_controls

map "<Cmd-Shift-.>" { growl('Hello, World') }

# Mac Outlook
only /Outlook/ do
  nmap "#", "<Delete>"
  nmap "y" do
    send("<Cmd-Shift-m>")
    send("Archive<Enter>")
  end
end

map "<Ctrl-f>" { get_controls }

# only "Mail" do 
#   nmap "c", "<Cmd-n>"                  # New message
#   nmap "j", "<Down>"                   # Down
#   nmap "k", "<Up>"                     # Up
#   nmap "e", "<Shift-Cmd-e>"            # Archive
#   nmap "<Shift-3>", "<Cmd-Backspace>"  # Delete
#   nmap "s", "<Shift-Cmd-l>"            # Star
#   nmap "r", "<Cmd-r>"                  # Reply
#   nmap "a", "<Shift-Cmd-r>"            # Reply all
#   nmap "f", "<Shift-Cmd-f>"            # Forward
#   nmap "z", "<Cmd-z>"                  # Undo
#   nmap "U", "<Shift-Cmd-u>"            # Mark as unread
#   nmap "<Cmd-Enter>", "<Shift-Cmd-d>"  # Send message
#   nmap "!", "Shift-Cmd-j>"             # Mark as junk
# end
# 

only /TextEdit/ do
  abbrev "nname", "Kevin Colyar"
end
abbrev 'ttime' { send(Time.now.strftime('%I:%M%p')) }
abbrev 'eemail' do 
  send("kevin@colyar.net<Return>"*10)
end

abbrev 'addr', '123 Test Street, New York, NY, 12345'
abbrev 'teh', 'the'

map '<cmd-down>' { alert(Keymando.version)}

only /Xcode/ do
  map ',r', '<Cmd-r>'
end

abbrev 'cclass' do 
  name = prompt("Enter Class Name")
  template = "class #{name}<Return>  def initialize()<Return>  end<Return>end"
  send(template)
end

# abbrev 'test' do 
#   pasteBoard = NSPasteboard.generalPasteboard
#   pasteBoard.declareTypes([NSStringPboardType], owner: nil)
#   pasteBoard.setString('ಠ_ಠ', forType: NSStringPboardType)
#   send('<Cmd-v>')
# end

# only /TextEdit/ do
#   map "a" { alert ("a") }
#   map "b" { growl("a unmapped"); unmap ("a") } 
# end


# only /TextEdit/ do
#   swap('Cmd', 'Alt')
# end
#

