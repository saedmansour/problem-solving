/**
 * Timeago is a jQuery plugin that makes it easy to support automatically
 * updating fuzzy timestamps (e.g. "4 minutes ago" or "about 1 day ago").
 *
 * @name timeago
 * @version 1.1.0
 * @requires jQuery v1.2.3+
 * @author Ryan McGeary
 * @license MIT License - http://www.opensource.org/licenses/mit-license.php
 *
 * For usage and examples, visit:
 * http://timeago.yarp.com/
 *
 * Copyright (c) 2008-2013, Ryan McGeary (ryan -[at]- mcgeary [*dot*] org)
 */


(function (factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['jquery'], factory);
  } else {
    // Browser globals
    factory(jQuery);
  }
}(function ($) {
  $.timeago = function(timestamp) {
    if (timestamp instanceof Date) {
      return inWords(timestamp);
    } else if (typeof timestamp === "string") {
      return inWords($.timeago.parse(timestamp));
    } else if (typeof timestamp === "number") {
      return inWords(new Date(timestamp));
    } else {
      return inWords($.timeago.datetime(timestamp));
    }
  };
  var $t = $.timeago;

  $.extend($.timeago, {
    settings: {
      refreshMillis: 60000,
      allowFuture: false,
      localeTitle: false,
      lang: "en",
      strings: { "en": {
        prefixAgo: null,
        prefixFromNow: null,
        suffixAgo: "ago",
        suffixFromNow: "from now",
        seconds: "less than a minute",
        minute: "about a minute",
        minutes: "%d minutes",
        hour: "about an hour",
        hours: "about %d hours",
        day: "a day",
        days: "%d days",
        month: "about a month",
        months: "%d months",
        year: "about a year",
        years: "%d years",
        wordSeparator: " ",
        numbers: []
      }}
    },
    inWords: function(distanceMillis, lang) {
      var $l = this.settings.strings[lang] || this.settings.strings[this.settings.lang] || this.settings.strings["en"];
      var prefix = $l.prefixAgo;
      var suffix = $l.suffixAgo;
      if (this.settings.allowFuture) {
        if (distanceMillis < 0) {
          prefix = $l.prefixFromNow;
          suffix = $l.suffixFromNow;
        }
      }

      var seconds = Math.abs(distanceMillis) / 1000;
      var minutes = seconds / 60;
      var hours = minutes / 60;
      var days = hours / 24;
      var years = days / 365;

      function substitute(stringOrFunction, number) {
        var string = $.isFunction(stringOrFunction) ? stringOrFunction(number, distanceMillis) : stringOrFunction;
        var value = ($l.numbers && $l.numbers[number]) || number;
        return string.replace(/%d/i, value);
      }

      var words = seconds < 45 && substitute($l.seconds, Math.round(seconds)) ||
        seconds < 90 && substitute($l.minute, 1) ||
        minutes < 45 && substitute($l.minutes, Math.round(minutes)) ||
        minutes < 90 && substitute($l.hour, 1) ||
        hours < 24 && substitute($l.hours, Math.round(hours)) ||
        hours < 42 && substitute($l.day, 1) ||
        days < 30 && substitute($l.days, Math.round(days)) ||
        days < 45 && substitute($l.month, 1) ||
        days < 365 && substitute($l.months, Math.round(days / 30)) ||
        years < 1.5 && substitute($l.year, 1) ||
        substitute($l.years, Math.round(years));

      var separator = $l.wordSeparator || "";
      if ($l.wordSeparator === undefined) { separator = " "; }
      return $.trim([prefix, words, suffix].join(separator));
    },
    parse: function(iso8601) {
      var s = $.trim(iso8601);
      s = s.replace(/\.\d+/,""); // remove milliseconds
      s = s.replace(/-/,"/").replace(/-/,"/");
      s = s.replace(/T/," ").replace(/Z/," UTC");
      s = s.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2"); // -04:00 -> -0400
      return new Date(s);
    },
    datetime: function(elem) {
      var iso8601 = $t.isTime(elem) ? $(elem).attr("datetime") : $(elem).attr("title");
      return $t.parse(iso8601);
    },
    isTime: function(elem) {
      // jQuery's `is()` doesn't play well with HTML5 in IE
      return $(elem).get(0).tagName.toLowerCase() === "time"; // $(elem).is("time");
    }
  });

  // functions that can be called via $(el).timeago('action')
  // init is default when no action is given
  // functions are called with context of a single element
  var functions = {
    init: function(){
      var refresh_el = $.proxy(refresh, this);
      refresh_el();
      var $s = $t.settings;
      if ($s.refreshMillis > 0) {
        setInterval(refresh_el, $s.refreshMillis);
      }
    },
    update: function(time){
      $(this).data('timeago', { datetime: $t.parse(time) });
      refresh.apply(this);
    }
  };

  $.fn.timeago = function(action, options) {
    var fn = action ? functions[action] : functions.init;
    if(!fn){
      throw new Error("Unknown function name '"+ action +"' for timeago");
    }
    // each over objects here and call the requested function
    this.each(function(){
      fn.call(this, options);
    });
    return this;
  };

  function refresh() {
    var data = prepareData(this);
    if (!isNaN(data.datetime)) {
      $(this).text(inWords(data.datetime, ($(this).attr('lang')) ? $(this).attr('lang') : $t.settings.lang));
    }
    return this;
  }

  function prepareData(element) {
    element = $(element);
    if (!element.data("timeago")) {
      element.data("timeago", { datetime: $t.datetime(element) });
      var text = $.trim(element.text());
      if ($t.settings.localeTitle) {
        element.attr("title", element.data('timeago').datetime.toLocaleString());
      } else if (text.length > 0 && !($t.isTime(element) && element.attr("title"))) {
        element.attr("title", text);
      }
    }
    return element.data("timeago");
  }

  function inWords(date, lang) {
    return $t.inWords(distance(date), lang);
  }

  function distance(date) {
    return (new Date().getTime() - date.getTime());
  }

  // fix for IE6 suckage
  document.createElement("abbr");
  document.createElement("time");
}));
//
// jQuery Timeago bootstrap for rails-timeago helper
//


(function($) {
	$(document).on('ready page:load', function() {
		$('time[data-time-ago]').each(function() {
			$(this).timeago();
		});
	});
})(jQuery);
// German
jQuery.timeago.settings.strings["de"] = {
  prefixAgo: "vor",
  prefixFromNow: "in",
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "wenigen Sekunden",
  minute: "etwa einer Minute",
  minutes: "%d Minuten",
  hour: "etwa einer Stunde",
  hours: "%d Stunden",
  day: "etwa einem Tag",
  days: "%d Tagen",
  month: "etwa einem Monat",
  months: "%d Monaten",
  year: "etwa einem Jahr",
  years: "%d Jahren"
};
// Welsh
jQuery.timeago.settings.strings["cy"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "yn ôl",
  suffixFromNow: "o hyn",
  seconds: "llai na munud",
  minute: "am funud",
  minutes: "%d munud",
  hour: "tua awr",
  hours: "am %d awr",
  day: "y dydd",
  days: "%d diwrnod",
  month: "tua mis",
  months: "%d mis",
  year: "am y flwyddyn",
  years: "%d blynedd",
  wordSeparator: " ",
  numbers: []
};
// Polish
(function() {
  function numpf(n, s, t) {
    // s - 2-4, 22-24, 32-34 ...
    // t - 5-21, 25-31, ...
    var n10 = n % 10;
    if ( (n10 > 1) && (n10 < 5) && ( (n > 20) || (n < 10) ) ) {
      return s;
    } else {
      return t;
    }
  }

  jQuery.timeago.settings.strings["pl"] = {
    prefixAgo: null,
    prefixFromNow: "za",
    suffixAgo: "temu",
    suffixFromNow: null,
    seconds: "mniej niż minutę",
    minute: "minutę",
    minutes: function(value) { return numpf(value, "%d minuty", "%d minut"); },
    hour: "godzinę",
    hours: function(value) { return numpf(value, "%d godziny", "%d godzin"); },
    day: "dzień",
    days: "%d dni",
    month: "miesiąc",
    months: function(value) { return numpf(value, "%d miesiące", "%d miesięcy"); },
    year: "rok",
    years: function(value) { return numpf(value, "%d lata", "%d lat"); }
  };
})();
// Macedonian
(function() {
 jQuery.timeago.settings.strings["mk"]={
    prefixAgo: "пред",
    prefixFromNow: "за",
    suffixAgo: null,
    suffixFromNow: null,
    seconds: "%d секунди",
    minute: "%d минута",
    minutes: "%d минути",
    hour: "%d час",
    hours: "%d часа",
    day: "%d ден",
    days: "%d денови" ,
    month: "%d месец",
    months: "%d месеци",
    year: "%d година",
    years: "%d години"
 }
})();
// Simplified Chinese
jQuery.timeago.settings.strings["zh-CN"] = {
  prefixAgo: null,
  prefixFromNow: "从现在开始",
  suffixAgo: "之前",
  suffixFromNow: null,
  seconds: "不到 1 分钟",
  minute: "大约 1 分钟",
  minutes: "%d 分钟",
  hour: "大约 1 小时",
  hours: "大约 %d 小时",
  day: "1 天",
  days: "%d 天",
  month: "大约 1 个月",
  months: "%d 月",
  year: "大约 1 年",
  years: "%d 年",
  numbers: [],
  wordSeparator: ""
};
// Bosnian
(function() {
  var numpf;

  numpf = function(n, f, s, t) {
    var n10;
    n10 = n % 10;
    if (n10 === 1 && (n === 1 || n > 20)) {
      return f;
    } else if (n10 > 1 && n10 < 5 && (n > 20 || n < 10)) {
      return s;
    } else {
      return t;
    }
  };

  jQuery.timeago.settings.strings["bs"] = {
    prefixAgo: "prije",
    prefixFromNow: "za",
    suffixAgo: null,
    suffixFromNow: null,
    second: "sekund",
    seconds: function(value) {
      return numpf(value, "%d sekund", "%d sekunde", "%d sekundi");
    },
    minute: "oko minut",
    minutes: function(value) {
      return numpf(value, "%d minut", "%d minute", "%d minuta");
    },
    hour: "oko sat",
    hours: function(value) {
      return numpf(value, "%d sat", "%d sata", "%d sati");
    },
    day: "oko jednog dana",
    days: function(value) {
      return numpf(value, "%d dan", "%d dana", "%d dana");
    },
    month: "mjesec dana",
    months: function(value) {
      return numpf(value, "%d mjesec", "%d mjeseca", "%d mjeseci");
    },
    year: "prije godinu dana ",
    years: function(value) {
      return numpf(value, "%d godinu", "%d godine", "%d godina");
    },
    wordSeparator: " "
  };

}).call(this);
// English shortened
jQuery.timeago.settings.strings["en-short"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "1m",
  minute: "1m",
  minutes: "%dm",
  hour: "1h",
  hours: "%dh",
  day: "1d",
  days: "%dd",
  month: "1mo",
  months: "%dmo",
  year: "1yr",
  years: "%dyr",
  wordSeparator: " ",
  numbers: []
};
// Italian
jQuery.timeago.settings.strings["it"] = {
  suffixAgo: "fa",
  suffixFromNow: "da ora",
  seconds: "meno di un minuto",
  minute: "circa un minuto",
  minutes: "%d minuti",
  hour: "circa un'ora",
  hours: "circa %d ore",
  day: "un giorno",
  days: "%d giorni",
  month: "circa un mese",
  months: "%d mesi",
  year: "circa un anno",
  years: "%d anni"
};
// Finnish
jQuery.timeago.settings.strings["fi"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "sitten",
  suffixFromNow: "tulevaisuudessa",
  seconds: "alle minuutti",
  minute: "minuutti",
  minutes: "%d minuuttia",
  hour: "tunti",
  hours: "%d tuntia",
  day: "päivä",
  days: "%d päivää",
  month: "kuukausi",
  months: "%d kuukautta",
  year: "vuosi",
  years: "%d vuotta"
};

// The above is not a great localization because one would usually
// write "2 days ago" in Finnish as "2 päivää sitten", however
// one would write "2 days into the future" as "2:n päivän päästä"
// which cannot be achieved with localization support this simple.
// This is because Finnish has word suffixes (attached directly
// to the end of the word). The word "day" is "päivä" in Finnish.
// As workaround, the above localizations will say
// "2 päivää tulevaisuudessa" which is understandable but
// not as fluent.
;
// Spanish
jQuery.timeago.settings.strings["es"] = {
   prefixAgo: "hace",
   prefixFromNow: "dentro de",
   suffixAgo: "",
   suffixFromNow: "",
   seconds: "menos de un minuto",
   minute: "un minuto",
   minutes: "unos %d minutos",
   hour: "una hora",
   hours: "%d horas",
   day: "un día",
   days: "%d días",
   month: "un mes",
   months: "%d meses",
   year: "un año",
   years: "%d años"
};
// Ukrainian
(function() {
  function numpf(n, f, s, t) {
    // f - 1, 21, 31, ...
    // s - 2-4, 22-24, 32-34 ...
    // t - 5-20, 25-30, ...
    var n10 = n % 10;
    if ( (n10 == 1) && ( (n == 1) || (n > 20) ) ) {
      return f;
    } else if ( (n10 > 1) && (n10 < 5) && ( (n > 20) || (n < 10) ) ) {
      return s;
    } else {
      return t;
    }
  }

  jQuery.timeago.settings.strings["uk"] = {
    prefixAgo: null,
    prefixFromNow: "через",
    suffixAgo: "тому",
    suffixFromNow: null,
    seconds: "менше хвилини",
    minute: "хвилина",
    minutes: function(value) { return numpf(value, "%d хвилина", "%d хвилини", "%d хвилин"); },
    hour: "година",
    hours: function(value) { return numpf(value, "%d година", "%d години", "%d годин"); },
    day: "день",
    days: function(value) { return numpf(value, "%d день", "%d дні", "%d днів"); },
    month: "місяць",
    months: function(value) { return numpf(value, "%d місяць", "%d місяці", "%d місяців"); },
    year: "рік",
    years: function(value) { return numpf(value, "%d рік", "%d роки", "%d років"); }
  };
})();
//Lithuanian      
jQuery.timeago.settings.strings["lt"] = {
  prefixAgo: "prieš",
  prefixFromNow: null,
  suffixAgo: null,
  suffixFromNow: "nuo dabar",
  seconds: "%d sek.",
  minute: "min.",
  minutes: "%d min.",
  hour: "val.",
  hours: "%d val.",
  day: "1 d.",
  days: "%d d.",
  month: "mėn.",
  months: "%d mėn.",
  year: "metus",
  years: "%d metus",
  wordSeparator: " ",
  numbers: []
};
// Traditional Chinese, zh-tw
jQuery.timeago.settings.strings["zh-TW"] = {
  prefixAgo: null,
  prefixFromNow: "從現在開始",
  suffixAgo: "之前",
  suffixFromNow: null,
  seconds: "不到 1 分鐘",
  minute: "大約 1 分鐘",
  minutes: "%d 分鐘",
  hour: "大約 1 小時",
  hours: "%d 小時",
  day: "大約 1 天",
  days: "%d 天",
  month: "大約 1 個月",
  months: "%d 個月",
  year: "大約 1 年",
  years: "%d 年",
  numbers: [],
  wordSeparator: ""
};
// Slovak
jQuery.timeago.settings.strings["sk"] = {
  prefixAgo: "pred",
  prefixFromNow: null,
  suffixAgo: null,
  suffixFromNow: null,
  seconds: "menej než minútou",
  minute: "minútou",
  minutes: "%d minútami",
  hour: "hodinou",
  hours: "%d hodinami",
  day: "1 dňom",
  days: "%d dňami",
  month: "1 mesiacom",
  months: "%d mesiacmi",
  year: "1 rokom",
  years: "%d rokmi"
};
// Armenian
jQuery.timeago.settings.strings["hy"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "առաջ",
  suffixFromNow: "հետո",
  seconds: "վայրկյաններ",
  minute: "մեկ րոպե",
  minutes: "%d րոպե",
  hour: "մեկ ժամ",
  hours: "%d ժամ",
  day: "մեկ օր",
  days: "%d օր",
  month: "մեկ ամիս",
  months: "%d ամիս",
  year: "մեկ տարի",
  years: "%d տարի"
};
// Catalan
jQuery.timeago.settings.strings["ca"] = {
  prefixAgo: "fa",
  prefixFromNow: "d'aqui a",
  suffixAgo: null,
  suffixFromNow: null,
  seconds: "menys d'1 minut",
  minute: "1 minut",
  minutes: "uns %d minuts",
  hour: "1 hora",
  hours: "unes %d hores",
  day: "1 dia",
  days: "%d dies",
  month: "aproximadament un mes",
  months: "%d mesos",
  year: "aproximadament un any",
  years: "%d anys"
};
// Portuguese
jQuery.timeago.settings.strings["pt"] = {
   suffixAgo: "atrás",
   suffixFromNow: "a partir de agora",
   seconds: "menos de um minuto",
   minute: "cerca de um minuto",
   minutes: "%d minutos",
   hour: "cerca de uma hora",
   hours: "cerca de %d horas",
   day: "um dia",
   days: "%d dias",
   month: "cerca de um mês",
   months: "%d meses",
   year: "cerca de um ano",
   years: "%d anos"
};
// Greek
jQuery.timeago.settings.strings["el"] = {
  prefixAgo: "πριν",
  prefixFromNow: "σε",
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "λιγότερο από ένα λεπτό",
  minute: "περίπου ένα λεπτό",
  minutes: "%d λεπτά",
  hour: "περίπου μία ώρα",
  hours: "περίπου %d ώρες",
  day: "μία μέρα",
  days: "%d μέρες",
  month: "περίπου ένα μήνα",
  months: "%d μήνες",
  year: "περίπου ένα χρόνο",
  years: "%d χρόνια"
};
// Swedish
jQuery.timeago.settings.strings["sv"] = {
  prefixAgo: "för",
  prefixFromNow: "om",
  suffixAgo: "sedan",
  suffixFromNow: "",
  seconds: "mindre än en minut",
  minute: "ungefär en minut",
  minutes: "%d minuter",
  hour: "ungefär en timme",
  hours: "ungefär %d timmar",
  day: "en dag",
  days: "%d dagar",
  month: "ungefär en månad",
  months: "%d månader",
  year: "ungefär ett år",
  years: "%d år"
};
// Language: Arabic
// Translated By Khaled Attia < Khal3d.com >
(function() {
  function numpf(num, w, x, y, z) {
    if( num == 0 ) {
      return w;
    } else if( num == 2 ) {
      return x;
    } else if( num >= 3 && num <= 10) {
      return y; // 3:10
    } else {
      return z; // 11+
    }
  }
  jQuery.timeago.settings.strings["ar"] = {
    prefixAgo: "منذ",
    prefixFromNow: "يتبقى",
    suffixAgo: null,
    suffixFromNow: null, // null OR "من الآن"
    seconds: function(value) { return numpf(value, "لحظات", "ثانيتين", "%d ثواني", "%d ثانيه"); },
    minute: "دقيقة",
    minutes: function(value) { return numpf(value, null, "دقيقتين", "%d دقائق", "%d دقيقة"); },
    hour: "ساعة",
    hours: function(value) { return numpf(value, null, "ساعتين", "%d ساعات", "%d ساعة"); },
    day: "يوم",
    days: function(value) { return numpf(value, null, "يومين", "%d أيام", "%d يوم"); },
    month: "شهر",
    months: function(value) { return numpf(value, null, "شهرين", "%d أشهر", "%d شهر"); },
    year: "سنه",
    years: function(value) { return numpf(value, null, "سنتين", "%d سنوات", "%d سنه"); }
  };
})();
// Norwegian
jQuery.timeago.settings.strings["no"] = {
  prefixAgo: "for",
  prefixFromNow: "om",
  suffixAgo: "siden",
  suffixFromNow: "",
  seconds: "mindre enn et minutt",
  minute: "ca. et minutt",
  minutes: "%d minutter",
  hour: "ca. en time",
  hours: "ca. %d timer",
  day: "en dag",
  days: "%d dager",
  month: "ca. en måned",
  months: "%d måneder",
  year: "ca. et år",
  years: "%d år"
};

// Persian
// Use DIR attribute for RTL text in Persian Language for ABBR tag .
// By MB.seifollahi@gmail.com
jQuery.timeago.settings.strings["fa"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "پیش",
  suffixFromNow: "از حال",
  seconds: "کمتر از یک دقیقه",
  minute: "حدود یک دقیقه",
  minutes: "%d دقیقه",
  hour: "حدود یک ساعت",
  hours: "حدود %d ساعت",
  day: "یک روز",
  days: "%d روز",
  month: "حدود یک ماه",
  months: "%d ماه",
  year: "حدود یک سال",
  years: "%d سال",
  wordSeparator: " "
};
// French
jQuery.timeago.settings.strings["fr"] = {
   // environ ~= about, it's optional
   prefixAgo: "il y a",
   prefixFromNow: "d'ici",
   seconds: "moins d'une minute",
   minute: "environ une minute",
   minutes: "environ %d minutes",
   hour: "environ une heure",
   hours: "environ %d heures",
   day: "environ un jour",
   days: "environ %d jours",
   month: "environ un mois",
   months: "environ %d mois",
   year: "un an",
   years: "%d ans"
};
// Brazilian Portuguese 
jQuery.timeago.settings.strings["pt-br"] = {
   suffixAgo: "atrás",
   suffixFromNow: "nesse momento",
   seconds: "alguns segundos",
   minute: "há um minuto",
   minutes: "há %d minutos",
   hour: "há uma hora",
   hours: "há %d horas",
   day: "há um dia",
   days: "há %d dias",
   month: "há um mês",
   months: "há %d meses",
   year: "há um ano",
   years: "há %d anos"
};
// Turkish
jQuery.extend($.timeago.settings.strings["tr"], {
   suffixAgo: 'önce',
   suffixFromNow: null,
   seconds: '1 dakikadan',
   minute: '1 dakika',
   minutes: '%d dakika',
   hour: '1 saat',
   hours: '%d saat',
   day: '1 gün',
   days: '%d gün',
   month: '1 ay',
   months: '%d ay',
   year: '1 yıl',
   years: '%d yıl'
});
// Hebrew
jQuery.timeago.settings.strings["he"] = {
  prefixAgo: "לפני",
  prefixFromNow: "מעכשיו",
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "פחות מדקה",
  minute: "דקה",
  minutes: "%d דקות",
  hour: "שעה",
  hours: "%d שעות",
  day: "יום",
  days: "%d ימים",
  month: "חודש",
  months: "%d חודשים",
  year: "שנה",
  years: "%d שנים"
};
// Bulgarian
jQuery.timeago.settings.strings["bg"] = {
  prefixAgo: "преди",
  prefixFromNow: "след",
  suffixAgo: null,
  suffixFromNow: null,
  seconds: "по-малко от минута",
  minute: "една минута",
  minutes: "%d минути",
  hour: "един час",
  hours: "%d часа",
  day: "един ден",
  days: "%d дни",
  month: "един месец",
  months: "%d месеца",
  year: "една година",
  years: "%d години"
};
// Korean
jQuery.timeago.settings.strings["ko"] = {
  suffixAgo: "전",
  suffixFromNow: "후",
  seconds: "1분 이내",
  minute: "1분",
  minutes: "%d분",
  hour: "1시간",
  hours: "%d시간",
  day: "하루",
  days: "%d일",
  month: "한 달",
  months: "%d달",
  year: "1년",
  years: "%d년",
  wordSeparator: " "
};
//Uzbek
jQuery.timeago.settings.strings["uz"] = {
  prefixAgo: null,
  prefixFromNow: "keyin",
  suffixAgo: "avval",
  suffixFromNow: null,
  seconds: "bir necha soniya",
  minute: "1 daqiqa",
  minutes: function(value) { return "%d daqiqa" },
  hour: "1 soat",
  hours: function(value) { return "%d soat" },
  day: "1 kun",
  days: function(value) { return "%d kun" },
  month: "1 oy",
  months: function(value) { return "%d oy" },
  year: "1 yil",
  years: function(value) { return "%d yil" },
  wordSeparator: " "
};
// Czech
jQuery.timeago.settings.strings["cz"] = {
  prefixAgo: "před",
  prefixFromNow: null,
  suffixAgo: null,
  suffixFromNow: null,
  seconds: "méně než minutou",
  minute: "minutou",
  minutes: "%d minutami",
  hour: "hodinou",
  hours: "%d hodinami",
  day: "1 dnem",
  days: "%d dny",
  month: "1 měsícem",
  months: "%d měsíci",
  year: "1 rokem",
  years: "%d roky"
};
// Slovenian with support for dual
(function () {
    var numpf;
    numpf = function (n, d, m) {
        if (n == 2) {
            return d;
        } else {
            return m;
        }
    };

    jQuery.timeago.settings.strings["sl"] = {
        prefixAgo: "pred",
        prefixFromNow: "čez",
        suffixAgo: null,
        suffixFromNow: null,
        second: "sekundo",
        seconds: function (value) {
            return numpf(value, "%d sekundama", "%d sekundami");
        },
        minute: "minuto",
        minutes: function (value) {
            return numpf(value, "%d minutama", "%d minutami");
        },
        hour: "uro",
        hours: function (value) {
            return numpf(value, "%d urama", "%d urami");
        },
        day: "dnevom",
        days: function (value) {
            return numpf(value, "%d dnevi", "%d dnevi");
        },
        month: "enim mescem",
        months: function (value) {
            return numpf(value, "%d mesecema", "%d meseci");
        },
        year: "enim letom",
        years: function (value) {
            return numpf(value, "%d letoma", "%d leti");
        },
        wordSeparator: " "
    };

}).call(this);
// Hungarian
jQuery.timeago.settings.strings["hu"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: null,
  suffixFromNow: null,
  seconds: "kevesebb mint egy perce",
  minute: "körülbelül egy perce",
  minutes: "%d perce",
  hour: "körülbelül egy órája",
  hours: "körülbelül %d órája",
  day: "körülbelül egy napja",
  days: "%d napja",
  month: "körülbelül egy hónapja",
  months: "%d hónapja",
  year: "körülbelül egy éve",
  years: "%d éve"
};
// Indonesian
jQuery.timeago.settings.strings["id"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "yang lalu",
  suffixFromNow: "dari sekarang",
  seconds: "kurang dari semenit",
  minute: "sekitar satu menit",
  minutes: "%d menit",
  hour: "sekitar sejam",
  hours: "sekitar %d jam",
  day: "sehari",
  days: "%d hari",
  month: "sekitar sebulan",
  months: "%d tahun",
  year: "sekitar setahun",
  years: "%d tahun"
};
// Croatian
(function () {
    var numpf;

    numpf = function (n, f, s, t) {
        var n10;
        n10 = n % 10;
        if (n10 === 1 && (n === 1 || n > 20)) {
            return f;
        } else if (n10 > 1 && n10 < 5 && (n > 20 || n < 10)) {
            return s;
        } else {
            return t;
        }
    };

    jQuery.timeago.settings.strings["hr"] = {
        prefixAgo: "prije",
        prefixFromNow: "za",
        suffixAgo: null,
        suffixFromNow: null,
        second: "sekundu",
        seconds: function (value) {
            return numpf(value, "%d sekundu", "%d sekunde", "%d sekundi");
        },
        minute: "oko minutu",
        minutes: function (value) {
            return numpf(value, "%d minutu", "%d minute", "%d minuta");
        },
        hour: "oko jedan sat",
        hours: function (value) {
            return numpf(value, "%d sat", "%d sata", "%d sati");
        },
        day: "jedan dan",
        days: function (value) {
            return numpf(value, "%d dan", "%d dana", "%d dana");
        },
        month: "mjesec dana",
        months: function (value) {
            return numpf(value, "%d mjesec", "%d mjeseca", "%d mjeseci");
        },
        year: "prije godinu dana",
        years: function (value) {
            return numpf(value, "%d godinu", "%d godine", "%d godina");
        },
        wordSeparator: " "
    };

}).call(this);
// Russian
(function() {
  function numpf(n, f, s, t) {
    // f - 1, 21, 31, ...
    // s - 2-4, 22-24, 32-34 ...
    // t - 5-20, 25-30, ...
    var n10 = n % 10;
    if ( (n10 == 1) && ( (n == 1) || (n > 20) ) ) {
      return f;
    } else if ( (n10 > 1) && (n10 < 5) && ( (n > 20) || (n < 10) ) ) {
      return s;
    } else {
      return t;
    }
  }

  jQuery.timeago.settings.strings["ru"] = {
    prefixAgo: null,
    prefixFromNow: "через",
    suffixAgo: "назад",
    suffixFromNow: null,
    seconds: "меньше минуты",
    minute: "минуту",
    minutes: function(value) { return numpf(value, "%d минута", "%d минуты", "%d минут"); },
    hour: "час",
    hours: function(value) { return numpf(value, "%d час", "%d часа", "%d часов"); },
    day: "день",
    days: function(value) { return numpf(value, "%d день", "%d дня", "%d дней"); },
    month: "месяц",
    months: function(value) { return numpf(value, "%d месяц", "%d месяца", "%d месяцев"); },
    year: "год",
    years: function(value) { return numpf(value, "%d год", "%d года", "%d лет"); }
  };
})();
// Dutch
jQuery.timeago.settings.strings["nl"] = {
  prefixAgo: null,
  prefixFromNow: "",
  suffixAgo: "geleden",
  suffixFromNow: "van nu",
  seconds: "minder dan een minuut",
  minute: "ongeveer een minuut",
  minutes: "%d minuten",
  hour: "ongeveer een uur",
  hours: "ongeveer %d uur",
  day: "een dag",
  days: "%d dagen",
  month: "ongeveer een maand",
  months: "%d maanden",
  year: "ongeveer een jaar",
  years: "%d jaar",
  wordSeparator: " ",
  numbers: []
};
// French shortened
jQuery.timeago.settings.strings["fr-short"] = {
   prefixAgo: "il y a",
   prefixFromNow: "d'ici",
   seconds: "moins d'une minute",
   minute: "une minute",
   minutes: "%d minutes",
   hour: "une heure",
   hours: "%d heures",
   day: "un jour",
   days: "%d jours",
   month: "un mois",
   months: "%d mois",
   year: "un an",
   years: "%d ans"
};
// Danish
jQuery.timeago.settings.strings["da"] = {
  prefixAgo: "for",
  prefixFromNow: "om",
  suffixAgo: "siden",
  suffixFromNow: "",
  seconds: "mindre end et minut",
  minute: "ca. et minut",
  minutes: "%d minutter",
  hour: "ca. en time",
  hours: "ca. %d timer",
  day: "en dag",
  days: "%d dage",
  month: "ca. en måned",
  months: "%d måneder",
  year: "ca. et år",
  years: "%d år"
};
// Japanese
jQuery.timeago.settings.strings["ja"] = {
  prefixAgo: "",
  prefixFromNow: "今から",
  suffixAgo: "前",
  suffixFromNow: "後",
  seconds: "1 分未満",
  minute: "約 1 分",
  minutes: "%d 分",
  hour: "約 1 時間",
  hours: "約 %d 時間",
  day: "約 1 日",
  days: "約 %d 日",
  month: "約 1 月",
  months: "約 %d 月",
  year: "約 1 年",
  years: "約 %d 年",
  wordSeparator: ""
};
// Romanian
$.timeago.settings.strings["ro"] = {
  prefixAgo: "acum",
  prefixFromNow: "in timp de",
  suffixAgo: "",
  suffixFromNow: "",
  seconds: "mai putin de un minut",
  minute: "un minut",
  minutes: "%d minute",
  hour: "o ora",
  hours: "%d ore",
  day: "o zi",
  days: "%d zile",
  month: "o luna",
  months: "%d luni",
  year: "un an",
  years: "%d ani"
};
// Thai
jQuery.timeago.settings.strings["th"] = {
  prefixAgo: null,
  prefixFromNow: null,
  suffixAgo: "ที่แล้ว",
  suffixFromNow: "จากตอนนี้",
  seconds: "น้อยกว่าหนึ่งนาที",
  minute: "ประมาณหนึ่งนาที",
  minutes: "%d นาที",
  hour: "ประมาณหนึ่งชั่วโมง",
  hours: "ประมาณ %d ชั่วโมง",
  day: "หนึ่งวัน",
  days: "%d วัน",
  month: "ประมาณหนึ่งเดือน",
  months: "%d เดือน",
  year: "ประมาณหนึ่งปี",
  years: "%d ปี",
  wordSeparator: "",
  numbers: []
};
// Rails timeago bootstrap with all locales










































;
