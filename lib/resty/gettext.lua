local ffi      = require "ffi"
local ffi_cdef = ffi.cdef
local ffi_str  = ffi.string
local ffi_load = ffi.load
local bit      = require("bit")
local rshift   = bit.rshift
local band     = bit.band
local pcall    = pcall
ffi_cdef[[
int libintl_version;
char *gettext(const char *__msgid);
char *dgettext(const char *__domainname, const char *__msgid);
char *dcgettext(const char *__domainname, const char *__msgid, int __category);
char *ngettext(const char *__msgid1, const char *__msgid2, unsigned long int __n);
char *dngettext(const char *__domainname, const char *__msgid1, const char *__msgid2, unsigned long int __n);
char *dcngettext(const char *__domainname, const char *__msgid1, const char *__msgid2, unsigned long int __n, int __category);
char *textdomain(const char *__domainname);
char *bindtextdomain(const char *__domainname, const char *__dirname);
char *bind_textdomain_codeset(const char *__domainname, const char *__codeset);
]]
local ok, lib = pcall(ffi_load, "gettextlib")
if not ok then
    ok, lib = pcall(ffi_load, "intl")
    assert(ok, "Unable to load gettext library. Please check that the gettext shared library is in a default search path for dynamic libraries of your operating system.")
end
local gettext = setmetatable({}, { __call = function(self, ...)
    local argc = select('#', ...)
    if argc == 1 then return self.gettext(...)    end
    if argc == 2 then return self.dgettext(...)   end
    if argc == 3 then return self.ngettext(...)   end
    if argc == 4 then return self.dngettext(...)  end
    return nil
end })
function gettext.gettext(msgid)
    return ffi_str(lib.gettext(msgid));
end
function gettext.dgettext(domainname, msgid)
    return ffi_str(lib.dgettext(domainname, msgid));
end
function gettext.dcgettext(domainname, msgid, category)
    return ffi_str(lib.dcgettext(domainname, msgid, category));
end
function gettext.ngettext(msgid1, msgid2, n)
    return ffi_str(lib.ngettext(msgid1, msgid2, n));
end
function gettext.dngettext(domainname, msgid1, msgid2, n)
    return ffi_str(lib.dngettext(domainname, msgid1, msgid2, n));
end
function gettext.dcngettext(domainname, msgid1, msgid2, n, category)
    return ffi_str(lib.dcngettext(domainname, msgid1, msgid2, n, category));
end
function gettext.textdomain(domainname)
    return ffi_str(lib.textdomain(domainname));
end
function gettext.bindtextdomain(domainname, dirname)
    return ffi_str(lib.bindtextdomain(domainname, dirname));
end
function gettext.bind_textdomain_codeset(domainname, codeset)
    return ffi_str(lib.bind_textdomain_codeset(domainname, codeset));
end
gettext.version = rshift(lib.libintl_version, 16) .. "." .. rshift(lib.libintl_version, 8) .. "." .. band(lib.libintl_version, 0xFF)
return gettext
