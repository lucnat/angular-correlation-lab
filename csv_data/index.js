var fs = require('fs')

const filename = process.argv[2];
const output = process.argv[3];

fs.readFile(filename, 'utf8', function(err, data)
{
    if (err)
    {
        // check and handle err
    }
    var lines = data.split('\n').slice(12,8204).join('\n');
    fs.writeFile(output, lines);
});
