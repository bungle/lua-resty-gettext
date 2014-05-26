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
local gt = ffi_load("libintl")
local gettext = setmetatable({}, { __call = function(self, msgid)
    return self.gettext(msgid)
end })
function gettext.gettext(msgid)
    return ffi_str(gt.gettext(msgid));
end
function gettext.dgettext(domainname, msgid)
    return ffi_str(gt.dgettext(domainname, msgid));
end
function gettext.dcgettext(domainname, msgid, category)
    return ffi_str(gt.dcgettext(domainname, msgid, category));
end
function gettext.ngettext(msgid1, msgid2, n)
    return ffi_str(gt.ngettext(msgid1, msgid2, n));
end
function gettext.dngettext(domainname, msgid1, msgid2, n)
    return ffi_str(gt.dngettext(domainname, msgid1, msgid2, n));
end
function gettext.dcngettext(domainname, msgid1, msgid2, n, category)
    return ffi_str(gt.dcngettext(domainname, msgid1, msgid2, n, category));
end
function gettext.textdomain(domainname)
    return ffi_str(gt.textdomain(domainname));
end
function gettext.bindtextdomain(domainname, dirname)
    return ffi_str(gt.bindtextdomain(domainname, dirname));
end
function gettext.bind_textdomain_codeset(domainname, codeset)
    return ffi_str(gt.bind_textdomain_codeset(domainname, codeset));
end
return gettext