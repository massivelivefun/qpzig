const std = @import("std");
const windows = std.os.windows;

const CRITICAL_SECTION = windows.CRITICAL_SECTION;
const DWORD = windows.DWORD;
const HANDLE = windows.HANDLE;

var QV_win32Event_: HANDLE;

var l_win32CritSect: CRITICAL_SECTION;
var l_tickMsec: DWORD = 10;
var l_tickPrio: c_int = 50;
var l_isRunning: bool;

pub fn QF_init() {
    windows.InitializeCriticalSection(&l_win32CritSect);
    QV_win32Event_ = windows.CreateEvent(null, false, false, null);
}

pub fn QF_enterCriticalSection() {
    windows.EnterCriticalSection(&l_win32CritSect);
}

pub fn QF_leaveCriticalSection() {
    windows.LeaveCriticalSection(&l_win32CritSect);
}

pub fn QF_stop() {
    l_isRunning = false;
    windows.WSASetEvent(QV_win32Event_);
}

pub fn QF_run() c_int {
    // Extra stuff
    return 0;
}

pub fn QF_setTickRate(ticksPerSec: u32, tickPrio: c_int) {
    if (ticksPerSec != 0) {
        l_tickMsec = 1000 / ticksPerSec;
    } else {
        l_tickMsec = 0;
    }
    l_tickPrio = tickPrio;
}

pub fn QF_consoleSetup() {

}

pub fn QF_consoleCleanup() {

}

// More functions here
