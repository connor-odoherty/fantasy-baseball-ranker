FORMATS = {
    time:                        '%I:%M%P',
    time24:                      '%H:%M',
    time24withzulu:              '%H:%MZ',
    time24withzone:              '%H:%M %Z',
    timewithzone:                '%-l:%M%P %Z',
    human_time:                  '%-l:%M %P',
    short_date:                  '%-m/%-d/%y',
    date:                        '%m/%d/%Y',
    dateshortyear:               '%m/%d/%y',
    param:                       '%Y-%m-%d',
    daymonth:                    '%_m/%d',
    dateyearfirst:               '%Y/%m/%d',
    monthyear:                   '%B %Y',
    yearandmonth:                '%Y/%m',
    monthname:                   '%B',
    shortmonthname:              '%b',
    shortmonthnameandday:        '%b %d',
    dayofweekfull:               '%A',
    shortday:                    '%^a',
    date_full_month:             '%B %-d, %Y',
    ymd:                         '%y%m%d',
    datetime:                    '%m/%d/%Y %2l:%M %P',
    datetimeshortyear:           '%m/%d/%y %2l:%M %P',
    datetimeyearfirst:           '%Y/%m/%d %2l:%M %P',
    datetimewithzone:            '%m/%d/%y %2l:%M %P %Z',
    datetimewithzoneyearfirst:   '%Y/%m/%d %H:%M %Z',
    datetime24:                  '%m/%d/%Y %H:%M',
    datetime24shortyear:         '%m/%d/%y %H:%M',
    datetime24yearfirst:         '%Y/%m/%d %H:%M',
    datetime24withzone:          '%m/%d/%y %H:%M %Z',
    datetime24withzoneyearfirst: '%Y/%m/%d %H:%M %Z',
    longdatetime24withzone:      '%m/%d/%Y %H:%M %Z',
    longdatetime24Z:             '%m/%d/%Y %H:%M Z',             # <- Careful with this time format, it implies the time is in Zulu, but does not ensure that
    datetimesecswithzone:        '%m/%d/%y %2l:%M:%S %P %Z',     #    the time is in Zulu. You'll need to do that before strftime-ing with this format
    datetimewithabbreviations:   '%a, %b %e, %-I:%M%P',
    datetimewithfulldayandmonth: '%A, %B %e, %-I:%M%P',
    edinospacedatetime:          '%y%m%d%H%M',
    iso8601_date_only:           '%Y-%m-%d',
    xmltime:                     '%H:%M:%S',
    short_wordy_date:            ->(time) { time.strftime("%a, %b #{time.day.ordinalize}, %Y") }, # looks like "Friday, January 1st, 2016"
    wordy_date:                  ->(time) { time.strftime("%A, %B #{time.day.ordinalize}, %Y") }, # looks like "Fri, Jan 1st, 2016"
    datetime_with_offset:        ->(time, offset) { time.strftime("%Y-%m-%d %H:%M:%S #{offset}") },
    isodatetime:                 '%Y-%m-%d %H:%M:%S',
    displaydatetime24:           '%m/%d/%y %H:%M'
}.freeze

Time::DATE_FORMATS[:datetimewithzone] = '%m/%d/%y %2l:%M %P %Z'