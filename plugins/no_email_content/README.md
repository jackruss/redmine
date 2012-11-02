# No Email Content

This plugin removes most of the specific ticket information from the
Redmine notification emails and replaces them with generic notices that
the ticket has been updated.  It is intended to allow users to safely
upload sensitive data without worrying that it will be mailed out over
unsecure channels

Currently only the following messages are filtered:
 
* new issues
* issue updates
* new attachments to issues

Additionally, there is no way to disable the behavior other than to
remove the plugin.
