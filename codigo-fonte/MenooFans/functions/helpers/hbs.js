var register = function(Handlebars) {
    var helpers = {
        isSinglePrice: function(arr, options) {
            if(arr.length === 1) {
                return options.fn(this);
            }else{
                return options.inverse(this);
            }
        },
        choosePriceIcon: function(position){
            if(position === 0){
                return "person";
            }else if(position === 1){
                return "group";
            }else if(position === 2){
                return "groups";
            }
        },
        numberFormat: function (value, options) {
            // Helper parameters
            var dl = options.hash['decimalLength'] || 2;
            var ts = options.hash['thousandsSep'] || ',';
            var ds = options.hash['decimalSep'] || '.';

            // Parse to float
            var value = parseFloat(value);

            // The regex
            var re = '\\d(?=(\\d{3})+' + (dl > 0 ? '\\D' : '$') + ')';

            // Formats the number with the decimals
            var num = value.toFixed(Math.max(0, ~~dl));

            // Returns the formatted number
            return (ds ? num.replace('.', ds) : num).replace(new RegExp(re, 'g'), '$&' + ts);
        }
    };

    if (Handlebars && typeof Handlebars.registerHelper === "function") {
        for (var prop in helpers) {
            Handlebars.registerHelper(prop, helpers[prop]);
        }
    } else {
        return helpers;
    }

};

module.exports.register = register;
module.exports.helpers = register(null);