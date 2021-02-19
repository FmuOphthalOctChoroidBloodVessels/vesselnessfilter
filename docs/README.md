# このプロジェクトが行うこと
OCT画像から脈絡膜層の血管走行パタンを抽出するために，以下の機能を提供します．
- データ形式の変換（img形式またはtiff形式を読み込み，NIfTI形式に変換）
- 減衰補正（[Zhou et al., 2018](https://pubmed.ncbi.nlm.nih.gov/31065413/)）
- ボリュームデータの二値化
- ２つのボリュームデータの差分の算出
- イメージの補数．白黒反転
- Hessian行列にもとづく血管走行パタンの抽出（[Dirk-Jan Kroon, 2021](https://jp.mathworks.com/matlabcentral/fileexchange/24409-hessian-based-frangi-vesselness-filter)）
- コントラスト調整（[imadjustn](https://jp.mathworks.com/help/images/ref/imadjustn.html)）
- マスク処理
- 最大輝度ピクセルを基準にした輝度の標準化
- イメージのサイズ変更

# このプロジェクトが有益な理由
脈絡膜血管を3次元再構築することにより，複雑な脈絡血管を立体的に観察することができます．また，血管3次元構造を反映した数理的解析を行えます．

# このプロジェクトの使い始め方
## 利用環境
このスクリプトはMATLAB2020aのApp Designerで開発され，Windows10Proで動作を確認しています．
またスタンドアロンアプリケーションとして実行ファイルを配布します．

## インストール方法
実行ファイル形式のインストーラ（MyAppInstaller_web.exe）を実行します

## アプリについて
### 概要
OCT画像を取り込み，眼底の血管走行パタンを抽出するための，各種画像処理機能を提供します．
各機能は独立したモジュールとなっており，モジュールごとに画像を読み込み，処理結果を保存します．
各モジュールにおける処理内容はバッチファイルとして.mat形式で保存されます．このバッチファイルを読み込むことにより，いつでも同じ処理を行うことができます．

### メニュー
#### Fileメニュー
- New Batch: 新しいバッチファイルを作成します
- Load Batch: 既存のバッチファイル（mat形式）を読み込みます
- Save Batch: 処理内容をバッチファイルとして保存します
- Run Batch: バッチファイルで記述された処理を実行します

#### Moduleメニュー
- IMG import: ボリュームデータ（img形式またはtiff形式）を読み込み，NIfTI形式に変換します．ほかの処理はNIfTI形式のデータに対して行われますので，かならず変換してください．
- Attenuation Correction: 減衰補正（[Zhou et al., 2018](https://pubmed.ncbi.nlm.nih.gov/31065413/)）
- Binarize: ボリュームデータの二値化
- Difference: ２つのボリュームデータの差分を算出します
- Complement: イメージの補数．白黒反転させます．
- Frangi Filter: Hessian行列にもとづく血管走行パタンの抽出（[Dirk-Jan Kroon, 2021](https://jp.mathworks.com/matlabcentral/fileexchange/24409-hessian-based-frangi-vesselness-filter)）
- Intensity Adjustment: コントラスト調整
- Mask: マスク処理
- Normalize: 最大輝度ピクセルを基準にした輝度の標準化
- Resize: イメージのサイズ変更

#### Editメニュー
- Module->Move Up Selected Module: Module List内で選択されたモジュールの順位をひとつ繰り上げます
- Module->Move Down Selected Module: Module List内で選択されたモジュールの順位をひとつ繰り下げます
- Module->Remove the Selected Module: Module List内で選択されたモジュールを削除します
- Module->Copy the Selected Module: Module List内で選択されたモジュールを複製します
- Specify the Selected Item: Current Module内で選択されたモジュールオプションの値を設定します（ウィンドウ下部のSpecifyボタンも同じ動作をします）

#### Utilメニュー
- Create Mask: マスク処理のためのファイルを作成します
- Display->NIfTI: NIfTIファイルをビューワーで開きます

### アプリの使い方
IMG importを例にアプリの使い方を紹介します．デフォルト値を変更する必要がない場合は，適宜飛ばして進んでください．
1. 新しいバッチファイルを開く（File->New Batch）
2. IMG importモジュールを追加（Module->IMG import）
3. 入力画像の選択（Current Module内のInput image file(s)を選択してSpecifyボタンをクリックし，画像ファイルを選ぶ）
4. ボリュームデータのサイズを入力する（Current Module内のInput volume size [H*W*Slices]を選択しSpecifyボタンをクリックし，必要事項を入力する）
5. 出力データの保存先を指定する（Current Module内のOutput directoryを選択してSpecifyボタンをクリックしディレクトリを選ぶ）
6. バッチファイルを保存（Fileメニュー->Save Batch）
7. バッチファイルを実行（Fileメニュー->Run Batch）

### ディレクトリ構成
以下の２つのディレクトリを用意するのが好ましい．
- Results: それぞれのモジュールの出力結果を保存する
- Jobs: バッチファイルを保存する

例：
<pre>
[result_dir] --- [Results_dir]
	      |
              -- [Jobs_dir]
                       |
                       |-- [task_dir1] 
                       |      |
                       |      -- job01_img_import.mat
                       |      |
                       |      -- job02_resize.mat
                       |      |
                       |      -- job03_complement_only_cube.mat
		       |      |
                       |
                       |-- [task_dir2] 
                       |      |
                       |      -- job01_atten_cor.mat
                              |
                              -- job02_norm.mat
                              |
                              -- job03_resize.mat
</pre>

### 各モジュールの説明
#### IMG import
ボリュームデータ（img形式またはtiff形式）を読み込み，NIfTI形式に変換します．ほかの処理はNIfTI形式のデータに対して行われますので，かならず変換してください．
- Input image file(s): img形式またはtiff形式のボリュームデータを指定してください．Angio (6mm x 6mm), cubeまたはflowcube画像（.img）．ファイル名の末尾は"_cube_z.img"または"_FlowCube.img"としてください．複数選択可．
- Input volume size [H*W*Slices]: ボリュームデータのサイズ（行数・列数・スライス数）
- Output directory: 保存先ディレクトリ
- Output format: niiのみ対応．選択不可．
#### Attenuation Correction
減衰補正（[Zhou et al., 2018](https://pubmed.ncbi.nlm.nih.gov/31065413/)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Binarize
ボリュームデータの二値化
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Global threshold: 二値化の閾値．閾値より上の値をすべて１に置換し，そのほかは０にします．
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Difference
２つのボリュームデータの差分を算出します
- Minuend image file: 被減数．減算の左側．複数選択「不可」
- Subtrahend image file: 減数．減算の右側．複数選択「不可」
- Output file: 出力ファイル．デフォルトでは，Minuend image fileのファイル名の左側に"diff_"を付加します
#### Complement
イメージの補数．白黒反転させます．
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Frangi Filter
Hessian行列にもとづく血管走行パタンの抽出（[Dirk-Jan Kroon, 2021](https://jp.mathworks.com/matlabcentral/fileexchange/24409-hessian-based-frangi-vesselness-filter)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- FrangiScaleRange: The range of sigmas used
- FrangiScaleRatio: Step size between sigmas
- FrangiAlpha: Frangi vesselness constant, treshold on Lambda2/Lambda3 determines if its a line(vessel) or a plane like structure
- FrangiBeta: Frangi vesselness constant, which determines the deviation from a blob like structure, 
- FrangiC: Frangi vesselness constant which gives the threshold between eigenvalues of noise and vessel structure. A thumb rule is dividing the greyvalues of the vessels by 4 till 6
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Intensity Adjustment
コントラスト調整
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- range_in [low high]: V の値を範囲 [0, 1] の新しい値にマッピングします．lowより小さい値は０にマッピングし、highより大きい値は１にマッピングします．
- range_out [low high]: low_in と high_in の間の値が low_out と high_out の間の値にマッピングされるように、V の値を J の新しい値にマッピングします。low_in より小さい値は low_out にクリップされ、high_in より大きい値は high_out にクリップされます。
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Mask
マスク処理
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Mask directory: マスクファイルが保存されているディレクトリ．Input image file(s)に対応する名前のファイルがない場合は処理が行われません．
- Output directory: 保存先ディレクトリ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Normalize
最大輝度ピクセルを基準にした輝度の標準化
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Norm Range [H]: 最大輝度ピクセルをみつける範囲（行方向）．
- Norm Range [W]: 最大輝度ピクセルをみつける範囲（列方向）．
- Norm Range [D]: 最大輝度ピクセルをみつける範囲（スライス方向）．
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Resize
イメージのサイズ変更
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Output size [H*W*]: 変更を希望するボリュームサイズ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞

### Unil（ユーティリティツール）の説明
#### Create Mask
マスク処理に用いるファイルを作成します．
- 入力：oct_segmentの出力ファイル(mat形式）
- 出力：NIfTI形式．ファイル名の先頭に"mask_"がつく．すべて同一のディレクトリに保存されている必要がある．
#### NIfTIファイルの表示
Util->Display->NIfTI

# このプロジェクトに関するヘルプをどこで得るか
ご質問・ご要望・バグ報告などは[issue](https://github.com/FmuOphthalOctChoroidBloodVessels/project_ume/issues)にて受け付けております．

# このプロジェクトのメンテナンス者とコントリビューター
このプロジェクトのソースコードは以下の者が作成しました．
- 岡本正博（mokamoto@fmu.ac.jp）：作成，保守









