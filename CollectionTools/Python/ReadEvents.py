import win32evtlog

# [Python for Win32 Extensions Help](http://timgolden.me.uk/pywin32-docs/contents.html)

class WindowsEvent:
    def __init__(self, channel_name = "Application"):
        self.ChannelName = channel_name

    def read_log(self):
        print("Opening : " + self.ChannelName)

        # http://timgolden.me.uk/pywin32-docs/win32evtlog__OpenEventLog_meth.html
        # EventLog keys: https://docs.microsoft.com/en-us/windows/desktop/eventlog/eventlog-key
        #  reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog

        log_handle = win32evtlog.OpenEventLog(None, self.ChannelName)

        # Path : str
        #     Event log name or Path of an export file
        # Flags : int
        #    EvtOpenChannelPath (1) or EvtOpenFilePath (2)
        # Session=None : PyEVT_HANDLE
        #    Handle to a remote session (see win32evtlog::EvtOpenSession), or None for local machine.
        win32evtlog.EvtOpenLog('', 1 , None)

        flags= win32evtlog.EVENTLOG_BACKWARDS_READ|win32evtlog.EVENTLOG_SEQUENTIAL_READ

        total = win32evtlog.GetNumberOfEventLogRecords(log_handle)
        print("Total: %d" % total)

        events=1
        while events:
            # https://docs.microsoft.com/en-us/windows/desktop/api/winbase/nf-winbase-readeventloga
            events=win32evtlog.ReadEventLog(log_handle, flags, 0)
            # http://timgolden.me.uk/pywin32-docs/PyEventLogRecord.html
            for event in events:
                print("%s: %s %d" % (event.TimeWritten.Format(), event.SourceName, event.EventID))
                data = event.StringInserts
                if data:
                    for msg in data:
                        print('\t'+msg)
                    print('')
        win32evtlog.CloseEventLog(log_handle)

    def check_channel_config(self):
        channel_config = win32evtlog.EvtOpenChannelConfig(self.ChannelName, None , 0 )

        # http://timgolden.me.uk/pywin32-docs/win32evtlog_EvtChannelLoggingConfigLogFilePath.html
        (log_file_path, ret) = win32evtlog.EvtGetChannelConfigProperty(channel_config, win32evtlog.EvtChannelLoggingConfigLogFilePath, 0)

        return (log_file_path, ret)

windows_event = WindowsEvent(channel_name = "Microsoft-Windows-DNS-Client/Operational")
#windows_event = WindowsEvent(channel_name = "Security")
print(windows_event.check_channel_config())
windows_event.read_log()
