local ffi        = require "ffi"
local ffi_cdef   = ffi.cdef
local ffi_str    = ffi.string
local ffi_load   = ffi.load
ffi_cdef[[
extern char *gettext (const char *__msgid);
extern char *dgettext (const char *__domainname, const char *__msgid);
extern char *dcgettext (const char *__domainname, const char *__msgid, int __category);
extern char *ngettext (const char *__msgid1, const char *__msgid2, unsigned long int __n);
extern char *dngettext (const char *__domainname, const char *__msgid1, const char *__msgid2, unsigned long int __n);
extern char *dcngettext (const char *__domainname, const char *__msgid1, const char *__msgid2, unsigned long int __n, int __category);
extern char *textdomain (const char *__domainname);
extern char *bindtextdomain (const char *__domainname, const char *__dirname);
extern char *bind_textdomain_codeset (const char *__domainname, const char *__codeset);
]]
local libintl = ffi_load("libintl")
local gettext = setmetatable({}, { __call = function(self, ...)
    local argc = select('#', ...)
    if argc == 1 then return self.gettext(...)    end
    if argc == 2 then return self.dgettext(...)   end
    if argc == 3 then return self.ngettext(...)   end
    if argc == 4 then return self.dngettext(...)  end
    if argc == 5 then return self.dcngettext(...) end
    return nil
end })
function gettext.gettext(msgid)
    return ffi_str(libintl.gettext(msgid));
end
function gettext.dgettext(domainname, msgid)
    return ffi_str(libintl.dgettext(domainname, msgid));
end
function gettext.dcgettext(domainname, msgid, category)
    return ffi_str(libintl.dcgettext(domainname, msgid, category));
end
function gettext.ngettext(msgid1, msgid2, n)
    return ffi_str(libintl.ngettext(msgid1, msgid2, n));
end
function gettext.dngettext(domainname, msgid1, msgid2, n)
    return ffi_str(libintl.dngettext(domainname, msgid1, msgid2, n));
end
function gettext.dcngettext(domainname, msgid1, msgid2, n, category)
    return ffi_str(libintl.dcngettext(domainname, msgid1, msgid2, n, category));
end
function gettext.textdomain(domainname)
    return ffi_str(libintl.textdomain(domainname));
end
function gettext.bindtextdomain(domainname, dirname)
    return ffi_str(libintl.bindtextdomain(domainname, dirname));
end
function gettext.bind_textdomain_codeset(domainname, codeset)
    return ffi_str(libintl.bind_textdomain_codeset(domainname, codeset));
end
return gettext