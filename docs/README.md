# このプロジェクトが行うこと
OCT画像から脈絡膜層の血管走行パタンを抽出するために，以下の機能を提供します．
- IMG import: データ形式の変換（img形式またはtiff形式を読み込み，NIfTI形式に変換）
- Attenuation Correction: 減衰補正（cf. [Zhou et al., 2018](https://pubmed.ncbi.nlm.nih.gov/31065413/)）
- Binarize: ボリュームデータの二値化（cf. [imbinarize](https://jp.mathworks.com/help/images/ref/imbinarize.html)）
- Difference: ２つのボリュームデータの差分の算出（cf. [imsubtract](https://jp.mathworks.com/help/images/ref/imsubtract.html)）
- Complement: イメージの補数．白黒反転（cf. [imcomplement](https://jp.mathworks.com/help/images/ref/imcomplement.html)）
- Frangi Filter: Hessian行列にもとづく血管走行パタンの抽出（cf. [Dirk-Jan Kroon, 2021](https://jp.mathworks.com/matlabcentral/fileexchange/24409-hessian-based-frangi-vesselness-filter)）
- Intensity Adjustment: コントラストの強調（cf. [imadjustn](https://jp.mathworks.com/help/images/ref/imadjustn.html)）
- Mask: マスク処理
- Normalize: 任意の区画における最大輝度が１になるように，各ピクセル値を区画における最大値で割って標準化
- Resize: イメージのサイズ変更（cf. [imresize](https://jp.mathworks.com/help/images/ref/imresize.html)）

# このプロジェクトが有益な理由
脈絡膜血管を3次元再構築することにより，複雑な脈絡血管を立体的に観察することができます．また，血管3次元構造を反映した数理的解析を行えます．

# このプロジェクトの使い始め方
## 利用環境
このスクリプトはMATLAB2020aのApp Designerで開発され，Windows10Proで動作を確認しています．
またスタンドアロンアプリケーションとして実行ファイルを配布します．

## インストール方法
実行ファイル形式のインストーラ（MyAppInstaller_web.exe）を実行します．
### インストーラーの入手方法
1. 最新バージョンは[こちら](https://github.com/FmuOphthalOctChoroidBloodVessels/vesselnessfilter/tree/main/src/vesselnesfilter)で入手できます
2. 最新バージョンをふくむすべてのリリースは[こちら](https://github.com/FmuOphthalOctChoroidBloodVessels/vesselnessfilter/releases/)で入手できます
### インストール手順
1. インストーラを実行
2. 最初のウィンドウが現れたら「次へ」ボタンをクリック
3. インストールフォルダーを選択（ショートカットが必要な場合は，「ショートカットをデスクトップに追加」にチェック）
4. MATLAB Runtimeのインストールに関する情報が現れるので，確認したら「次へ」
5. インストールが正常に完了したら，「終了」ボタンを押してインストール完了です．
### その他
* デフォルトのインストールフォルダは"C:\Program Files\Fukushima Medical University"です
* アンインストールは各OSの手順に従ってください．（Windows10の場合は「プログラムの追加と削除」から行えます）
* アップデートは「インストール手順」と同様の手順で行うことができます（異なるバージョンを共存させる場合は，インストール先を変てください）

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
- Attenuation Correction: 減衰補正（cf. [Zhou et al., 2018](https://pubmed.ncbi.nlm.nih.gov/31065413/)）
- Binarize: ボリュームデータの二値化（cf. [imbinarize](https://jp.mathworks.com/help/images/ref/imbinarize.html)）
- Difference: ２つのボリュームデータの差分の算出（cf. [imsubtract](https://jp.mathworks.com/help/images/ref/imsubtract.html)）
- Complement: イメージの補数．白黒反転（cf. [imcomplement](https://jp.mathworks.com/help/images/ref/imcomplement.html)）
- Frangi filter: Hessian行列にもとづく血管走行パタンの抽出（cf. [Dirk-Jan Kroon, 2021](https://jp.mathworks.com/matlabcentral/fileexchange/24409-hessian-based-frangi-vesselness-filter)）
- Intensity Adjustment: コントラスト調整（cf. [imadjustn](https://jp.mathworks.com/help/images/ref/imadjustn.html)）
- Mask: マスク処理
- Normalize: 最大輝度ピクセルを基準にした輝度の標準化
- Reseize: イメージのサイズ変更（cf. [imresize](https://jp.mathworks.com/help/images/ref/imresize.html)）

#### Editメニュー
- Module->Move Up Selected Module: Module List内で選択されたモジュールの順位をひとつ繰り上げます
- Module->Move Down Selected Module: Module List内で選択されたモジュールの順位をひとつ繰り下げます
- Module->Remove the Selected Module: Module List内で選択されたモジュールを削除します
- Module->Copy the Selected Module: Module List内で選択されたモジュールを複製します
- Specify the Selected Item: Current Module内で選択されたモジュールオプションの値を設定します（ウィンドウ下部のSpecifyボタンも同じ動作をします）

#### Utilメニュー
- Create Mask: マスク処理のためのファイルを作成します
- Disp Image -> NIfTI: NIfTIファイルをビューワーで開きます
- Disp Image -> TIF: TIFファイルをビューワーで開きます
- Disp Image -> IMG: IMGファイル（ディスクイメージ）をビューワーで開きます
- Disp Image Info -> NIfTI: NIfTIファイルの情報を表示します
- Disp Image Info -> TIF: TIFファイルの情報を表示します
- Dir Operations -> Show Current Directory: 現在の作業ディレクトリを表示します
- Dir Operations -> Change Working Directory: 作業ディレクトリを変更します（作業ディレクトリをプロジェクトディレクトリに変更しておくと便利です）

### アプリの使い方
IMG importを例にアプリの使い方を紹介します．デフォルト値を変更する必要がない場合は，適宜飛ばして進んでください．
1. 新しいバッチファイルを開く（File->New Batch）
2. IMG importモジュールを追加（Module->IMG import）
3. 入力画像の選択（Current Module内のInput image file(s)を選択してSpecifyボタンをクリックし，画像ファイルを選ぶ）
4. ボリュームデータのサイズを入力する（Current Module内のInput volume size [H*W*Slices]を選択しSpecifyボタンをクリックし，必要事項を入力する）
5. 出力データの保存先を指定する（Current Module内のOutput directoryを選択してSpecifyボタンをクリックしディレクトリを選ぶ）
6. バッチファイルを保存（Fileメニュー->Save Batch）
7. バッチファイルを実行（Fileメニュー->Run Batch）

### 各モジュールの出力について
各モジュールは独立しており，それぞれ処理結果を出力します．出力ファイルのファイル名の先頭に接頭辞（Prefix）をつけることで，出力ファイルが区別されるようにしています．Prefixは各モジュールの設定画面で変更することができます．異なるモジュールで同一のprefixを用いると区別できなくなる恐れがあるのでご注意ください．

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
減衰補正（cf. [Zhou et al., 2018](https://pubmed.ncbi.nlm.nih.gov/31065413/)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Binarize
ボリュームデータの二値化（cf. [imbinarize](https://jp.mathworks.com/help/images/ref/imbinarize.html)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Global threshold: 二値化の閾値．閾値より上の値をすべて１に置換し，そのほかは０にします．
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Difference
２つのボリュームデータの差分の算出（cf. [imsubtract](https://jp.mathworks.com/help/images/ref/imsubtract.html)）
- Minuend image file: 被減数．減算の左側．複数選択「不可」
- Subtrahend image file: 減数．減算の右側．複数選択「不可」
- Output file: 出力ファイル．デフォルトでは，Minuend image fileのファイル名の左側に"diff_"を付加します
#### Complement
イメージの補数．白黒反転（cf. [imcomplement](https://jp.mathworks.com/help/images/ref/imcomplement.html)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Frangi Filter
Hessian行列にもとづく血管走行パタンの抽出（cf. [Dirk-Jan Kroon, 2021](https://jp.mathworks.com/matlabcentral/fileexchange/24409-hessian-based-frangi-vesselness-filter)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- FrangiScaleRange: The range of sigmas used
- FrangiScaleRatio: Step size between sigmas
- FrangiAlpha: Frangi vesselness constant, treshold on Lambda2/Lambda3 determines if its a line(vessel) or a plane like structure
- FrangiBeta: Frangi vesselness constant, which determines the deviation from a blob like structure, 
- FrangiC: Frangi vesselness constant which gives the threshold between eigenvalues of noise and vessel structure. A thumb rule is dividing the greyvalues of the vessels by 4 till 6
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Intensity Adjustment
コントラストの強調．ボリュームデータ全体で最小値が０，最大値が１になるように輝度を調整します．その際，出力イメージのコントラストが強調されるように，非線形の調整を行います．（詳しくは [imadjustn](https://jp.mathworks.com/help/images/ref/imadjustn.html)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- range_in [low high]: ボリュームデータの値を範囲 [0, 1] の新しい値にマッピングします．lowより小さい値は０にマッピングし、highより大きい値は１にマッピングします．
- range_out [low high]: low_in と high_in の間の値が low_out と high_out の間の値にマッピングされるように、ボリュームデータの値を出力の新しい値にマッピングします。low_in より小さい値は low_out にクリップされ、high_in より大きい値は high_out にクリップされます。
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Mask
マスク処理
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Mask directory: マスクファイルが保存されているディレクトリ．Input image file(s)に対応する名前のファイルがない場合は処理が行われません．
- Output directory: 保存先ディレクトリ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Normalize
最大輝度ピクセルを基準にした輝度の標準化：参照領域の最大値が１になるように，参照領域の最大値で各ピクセル値を割って輝度を調整します．
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Norm Range [H]: 最大輝度ピクセルをみつける範囲（行方向）．
- Norm Range [W]: 最大輝度ピクセルをみつける範囲（列方向）．
- Norm Range [D]: 最大輝度ピクセルをみつける範囲（スライス方向）．
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞
#### Resize
イメージのサイズ変更（cf. [imresize](https://jp.mathworks.com/help/images/ref/imresize.html)）
- Input image file(s): NIfTI形式のボリュームデータを指定してください．複数選択可．
- Output directory: 保存先ディレクトリ
- Output size [H*W*]: 変更を希望するボリュームサイズ
- Prefix: 出力データを保存する際にファイル名に付加する接頭辞

### Editツールの説明
#### Module List内の操作
モジュールリスト内に表示されたモジュールに対する操作を行います（Module List内で右クリックをすると同様の操作を行えます）
- Module -> Move Up Selected Module: ハイライトされたモジュールをリストの一つ上に移動します
- Module -> Move Down Selected Module: ハイライトされたモジュールをリストの一つ下に移動します
- Module -> Remove the Selected Module: ハイライトされたモジュールを削除します
- Module -> Remove All Modules: リスト内のすべてのモジュールを削除します
#### Specify the Selected Item
Specifyボタンと同じ動作をします

### Unil（ユーティリティツール）の説明
#### Create Mask
マスク処理に用いるファイルを作成します．
- 入力：oct_segmentの出力ファイル(mat形式）
- 出力：NIfTI形式．ファイル名の先頭に"mask_"がつく．すべて同一のディレクトリに保存されている必要がある．
#### ボリュームデータの表示
NIfTI, TIF, IMGデータの三次元直交ビューで表示します
- Disp Image -> NIfTI: NIfTIファイルをビューワーで開きます
- Disp Image -> TIF: TIFファイルをビューワーで開きます
- Disp Image -> IMG: IMGファイル（ディスクイメージ）をビューワーで開きます
#### ボリュームデータの情報表示
NIfTI, TIFデータの情報を表示します
- Disp Image Info -> NIfTIファイルの情報を表示します
- Disp Image Info -> TIFファイルの情報を表示します
#### 作業法ディレクトリの操作
- Dir Operations -> Show Current Directory: 現在の作業ディレクトリをINFO欄に表示します
- Dir Operations -> Change Working Directory: 作業ディレクトリを変更します

# このプロジェクトに関するヘルプをどこで得るか
* バグ報告・ご要望などは[issue](https://github.com/FmuOphthalOctChoroidBloodVessels/vesselnessfilter/issues)にて受け付けております．
* ご質問などは[GitHub Discussions](https://github.com/FmuOphthalOctChoroidBloodVessels/vesselnessfilter/discussions)にて受け付けております．GitHub Discussionについては[ドキュメンテーション](https://docs.github.com/ja/discussions/collaborating-with-your-community-using-discussions/participating-in-a-discussion)をご覧ください．

# 引用
このソフトウェアを使った研究を学術文献として発表する場合は以下の文献を引用していただけると大変うれしいです
- Sekiryu, Tetsuju, Yukinori Sugano, Akira Ojima, Takafumi Mori, Minoru Furuta, Masahiro Okamoto, and Satoshi Eifuku. 2019. “Hybrid Three-Dimensional Visualization of Choroidal Vasculature Imaged by Swept-Source Optical Coherence Tomography.” Translational Vision Science & Technology 8 (5): 31.
- Tsuji, Shingo, Tetsuju Sekiryu, Yukinori Sugano, Akira Ojima, Akihito Kasai, Masahiro Okamoto, and Satoshi Eifuku. 2020. “Semantic Segmentation of the Choroid in Swept Source Optical Coherence Tomography Images for Volumetrics.” Scientific Reports 10 (1): 1088.
- DOI:
	-v1.1.2: [![DOI](https://zenodo.org/badge/340243535.svg)](https://zenodo.org/badge/latestdoi/340243535)

# このプロジェクトのメンテナンス者とコントリビューター
このプロジェクトのソースコードは以下の者が作成しました．
- 岡本正博（mokamoto@fmu.ac.jp）：作成，保守
