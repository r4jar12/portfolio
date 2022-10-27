/*******************************************************************************
 車体を表すクラス
*******************************************************************************/
public class Car{
	private double x = 0.0;                       //位置 x座標
	private double y = 0.0;                       //位置 y座業
	private int direction = 0;                    //向き
	private String name = null;                   //名前

	private Handle handle = new Handle();         //ハンドル
	private Tire tire = new Tire();               //タイヤ
	private Accel accel = new Accel();            //アクセル
	private Brake brake = new Brake();            //ブレーキ

	//---------------------------------------------------------------
	// 引数なしコンストラクタ
	// 引数 : なし
	//---------------------------------------------------------------
	public Car(){
	}

	//---------------------------------------------------------------
	// 車の名前を指定するコンストラクタ
	// 引数 : name 車の名前
	//---------------------------------------------------------------
	public Car(String name){
		this.name = name;
	}

	//---------------------------------------------------------------
	// 運転装置を保持したまま移動する
	// 引数 : なし
	// 戻値 : なし
	//---------------------------------------------------------------
	public void move(){
		brake.renewSpeed(tire);
		accel.renewSpeed(tire);
		
		move_car();
	}

	//---------------------------------------------------------------
	// 運転装置を操作しながら移動する
	// 引数 : brake_d_push ブレーキの踏み込み変化量
	//        accel_d_push アクセルの踏み込み変化量
	//        handle_d_rotate ハンドルの角度変化量
	// 戻値 : なし
	//---------------------------------------------------------------
	public void move(int brake_d_push, int accel_d_push, int handle_d_rotate){
		handle.moveDirection(handle_d_rotate, tire);
		brake.movePush(brake_d_push, tire);
		accel.movePush(accel_d_push, tire);
		
		move_car();
	}

	//---------------------------------------------------------------
	// 車の名前を設定する
	// 引数 : name 車の名前
	// 戻値 : なし
	//---------------------------------------------------------------
	public void setName(String name){
		this.name = name;
	}

	//---------------------------------------------------------------
	// 車のx座標を得る
	// 引数 : なし
	// 戻値 : x座標
	//---------------------------------------------------------------
	public double getX(){
		return x;
	}

	//---------------------------------------------------------------
	// 車のy座標を得る
	// 引数 : なし
	// 戻値 : y座標
	//---------------------------------------------------------------
	public double getY(){
		return y;
	}

	//---------------------------------------------------------------
	// 車の向きを得る
	// 引数 : なし
	// 戻値 : 車の向き
	//---------------------------------------------------------------
	public int getDirection(){
		return direction;
	}

	//---------------------------------------------------------------
	// 車移動の共通処理
	// 引数 : なし
	// 戻値 : なし
	//---------------------------------------------------------------
	private void move_car(){
		int speed = tire.getSpeed();
		int direction = tire.getDirection();
		
		this.direction += direction;
                //もう少し本物っぽく動かす式（前輪が転がった分だけ車体が回転するので、速度0のときの回転も止まる。ホイールベース18mとして簡易計算）
//		this.direction += (int)((double)speed * Math.sin((double)direction * Math.PI / 180.0) * 3.0 / Math.PI);
		this.direction %= 360;             //向きを-359～+359にする
		if(this.direction > 179){          //向きを-180～+179にする
			this.direction -= 360;
		}else if(this.direction < -180){
			this.direction += 360;
		}
		
		x = x + (double)speed * Math.sin((double)this.direction * Math.PI / 180.0) / 3.6;
		y = y + (double)speed * Math.cos((double)this.direction * Math.PI / 180.0) / 3.6;
	}
}
