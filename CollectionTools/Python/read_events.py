import win32evtlog

# [Python for Win32 Extensions Help](http://timgolden.me.uk/pywin32-docs/contents.html)

class WindowsEvent:
    def __init__(self, machine_name = '', source_name = "Application"):
        self.MachineName = machine_name
        self.SourceName = source_name

    def read_log(self):
        print("Opening : " + self.SourceName)

        # http://timgolden.me.uk/pywin32-docs/win32evtlog__OpenEventLog_meth.html
        # https://docs.microsoft.com/en-us/windows/win32/eventlog/querying-for-event-source-messages
        # EventLog keys: https://docs.microsoft.com/en-us/windows/desktop/eventlog/eventlog-key
        #  reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog

        log_handle = win32evtlog.OpenEventLog(self.MachineName, self.SourceName)

        if log_handle is None:
            return

        # Path : str
        #     Event log name or Path of an export file
        # Flags : int
        #    EvtOpenChannelPath (1) or EvtOpenFilePath (2)
        # Session=None : PyEVT_HANDLE
        #    Handle to a remote session (see win32evtlog::EvtOpenSession), or None for local machine.
        # win32evtlog.EvtOpenLog('ForwardedEvents', 1 , None)

        flags= win32evtlog.EVENTLOG_BACKWARDS_READ | win32evtlog.EVENTLOG_SEQUENTIAL_READ
        total = win32evtlog.GetNumberOfEventLogRecords(log_handle)
        print("Total: %d" % total)

        events = 1
        while events:
            # https://docs.microsoft.com/en-us/windows/desktop/api/winbase/nf-winbase-readeventloga
            events = win32evtlog.ReadEventLog(log_handle, flags, 0)
            # http://timgolden.me.uk/pywin32-docs/PyEventLogRecord.html
            for event in events:
                if not event:
                    break

                print("%s: %s %d" % (event.TimeWritten.Format(), event.SourceName, event.EventID))
                if event.StringInserts:
                    for string_insert in event.StringInserts:
                        print('\t' + string_insert)
                    print('')

        win32evtlog.CloseEventLog(log_handle)

    def check_channel_config(self):
        channel_config = win32evtlog.EvtOpenChannelConfig(self.SourceName, None , 0 )
        # http://timgolden.me.uk/pywin32-docs/win32evtlog_EvtChannelLoggingConfigLogFilePath.html
        (log_file_path, ret) = win32evtlog.EvtGetChannelConfigProperty(channel_config, win32evtlog.EvtChannelLoggingConfigLogFilePath, 0)

        return (log_file_path, ret)

if __name__ == '__main__':
    import sys

    source_name = sys.argv[1]
    windows_event = WindowsEvent(source_name = source_name)
    windows_event.read_log()
