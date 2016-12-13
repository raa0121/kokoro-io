class Program
{
    name: string;

    constructor(public message: string){}

    exec()
    {
        console.log(this.message);
    }
}

var program= new Program('hello kokoro.io');

program.exec();
