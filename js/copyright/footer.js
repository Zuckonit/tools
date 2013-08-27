function footer (startYear, author) {
    var mdate = new Date();
    var year  = mdate.getFullYear();
    if (year == startYear) {
        str = "© " + startYear;
    }
    else if (year > startYear) {
        str = "© " + startYear + " ~ " + year;
    }
    return str + " Proudly powered by @" + author;
}
