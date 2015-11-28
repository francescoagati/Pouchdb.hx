typedef Row<T> = {
  id:String,
  key:String,
  value: {_rev:String},
  doc:T
}

typedef Rows<T> = {
  rows:Array<Row<T>>,
  total_rows:Int,
  offset:Int
}

@:native("PouchDB")
extern class Pouch<T> {
  public function new<T>(?db:String) {}
  public function put<T>(obj:T, cb:Dynamic->T->Void):Void {}
  public function allDocs<T>(?options:Dynamic, cb:Dynamic->Rows<T>->Void):Void {}
}

typedef Player = {
  name:String,
  surname:String
}

class Main implements async_tools.Async {


  @:async static inline function process_db() {
    var db = new Pouch<Player>('objects');

    var obj = {
      name:'pippo',
      surname:'gina',
      _id:"1"
    };

    var err,res = @await db.put(obj);
    trace(res);
    var err,rt:Rows<Player> = @await db.allDocs({include_docs: true, descending: true});
    for (row in rt.rows) trace(row.doc.name);

  }

  public static function main() {

    process_db(function() {});

  }
}
