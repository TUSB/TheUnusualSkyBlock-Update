# TheUnusualSkyBlock-Update

TheUnusualSkyBlockのアップデートデータパック用リポジトリ

# ブランチ構成

* `main`  
  テンプレートブランチ
* `1-19-4`(例)  
  MCverごとのテンプレートブランチ  
  pack.mcmetaの`pack_format`の数値を管理
* `v13-0-1-alpha2`(例)  
  ブランチ名のバージョンへのアップデート用ファイルが実装されたブランチ

# アップデートデータパックの作り方

1. アップデートの差分をメインリポジトリから取得する  
  ```
  git archive 1-19-4 `git diff --name-only HEAD HEAD~5` -o archive.zip
  ```
  このようなコマンドを用いて、アップデートで追加・変更があるファイルを取得する。  
  削除には非対応

2. アップデート用タグを打つ  
  まずは、
  ```mcfunction
  data modify storage v13alpha: UpdatingVersion set value {Major:0,Minor:0}
  ```
  このコマンドが記述されたfunctionファイルを用意する。そのとき、MajorとMinorをアップデートするバージョンに指定しておく。  
  このfunctionファイルを`tags/function`の`settings:version_update/check`へ追記する。  
  replaceがtrueになっている必要がある。

3. アップデート処理を追加する  
  これは任意ではあるが、アップデート時に一回だけ実行したい処理を追加することができる。
  ```mcfunction
  execute if data storage v13alpha: {Version:{Major:0}} if score $World Calc matches ..0 run function settings:version_update/update/...
  ```
  上のものが例である。  
  このように条件によって処理を実行するfunctionファイルを用意する。  
  `v13alpha: {Version:{Major,Minor}}`でアップデートの番号を指定できるほか、$World Calcにはアップデート前のマイナーバージョン値が記録されている。  
  このfunctionファイルを`tags/function`の`settings:version_update/update`へ追記する。  
  replaceはfalseでよい。  
  条件の先のfunctionでは自由に処理を記述できる。
