//@ pragma UseQApplication
import Quickshell

import qs.panel
import qs.bar
import qs.notification
import qs.wlogout
import qs.osd
import qs.input_method
import qs.lock

// TODO fix warnings

ShellRoot {
  Bar {}
  Launcher {}
  NotificationWindow {}
  Panel {}
  Logout {} // TODO make this look better and be keyboard driven
  Volume {}
  BrightnessOSD {}
  Lockscreen {}
  // bluetooth manager
  // greeter
  Emoji {}
  WiktionarySearcher {}
}
