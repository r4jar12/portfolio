/*******************************************************************************
 �ԑ̂�\���N���X
*******************************************************************************/
public class Car{
	private double x = 0.0;                       //�ʒu x���W
	private double y = 0.0;                       //�ʒu y����
	private int direction = 0;                    //����
	private String name = null;                   //���O

	private Handle handle = new Handle();         //�n���h��
	private Tire tire = new Tire();               //�^�C��
	private Accel accel = new Accel();            //�A�N�Z��
	private Brake brake = new Brake();            //�u���[�L

	//---------------------------------------------------------------
	// �����Ȃ��R���X�g���N�^
	// ���� : �Ȃ�
	//---------------------------------------------------------------
	public Car(){
	}

	//---------------------------------------------------------------
	// �Ԃ̖��O���w�肷��R���X�g���N�^
	// ���� : name �Ԃ̖��O
	//---------------------------------------------------------------
	public Car(String name){
		this.name = name;
	}

	//---------------------------------------------------------------
	// �^�]���u��ێ������܂܈ړ�����
	// ���� : �Ȃ�
	// �ߒl : �Ȃ�
	//---------------------------------------------------------------
	public void move(){
		brake.renewSpeed(tire);
		accel.renewSpeed(tire);
		
		move_car();
	}

	//---------------------------------------------------------------
	// �^�]���u�𑀍삵�Ȃ���ړ�����
	// ���� : brake_d_push �u���[�L�̓��ݍ��ݕω���
	//        accel_d_push �A�N�Z���̓��ݍ��ݕω���
	//        handle_d_rotate �n���h���̊p�x�ω���
	// �ߒl : �Ȃ�
	//---------------------------------------------------------------
	public void move(int brake_d_push, int accel_d_push, int handle_d_rotate){
		handle.moveDirection(handle_d_rotate, tire);
		brake.movePush(brake_d_push, tire);
		accel.movePush(accel_d_push, tire);
		
		move_car();
	}

	//---------------------------------------------------------------
	// �Ԃ̖��O��ݒ肷��
	// ���� : name �Ԃ̖��O
	// �ߒl : �Ȃ�
	//---------------------------------------------------------------
	public void setName(String name){
		this.name = name;
	}

	//---------------------------------------------------------------
	// �Ԃ�x���W�𓾂�
	// ���� : �Ȃ�
	// �ߒl : x���W
	//---------------------------------------------------------------
	public double getX(){
		return x;
	}

	//---------------------------------------------------------------
	// �Ԃ�y���W�𓾂�
	// ���� : �Ȃ�
	// �ߒl : y���W
	//---------------------------------------------------------------
	public double getY(){
		return y;
	}

	//---------------------------------------------------------------
	// �Ԃ̌����𓾂�
	// ���� : �Ȃ�
	// �ߒl : �Ԃ̌���
	//---------------------------------------------------------------
	public int getDirection(){
		return direction;
	}

	//---------------------------------------------------------------
	// �Ԉړ��̋��ʏ���
	// ���� : �Ȃ�
	// �ߒl : �Ȃ�
	//---------------------------------------------------------------
	private void move_car(){
		int speed = tire.getSpeed();
		int direction = tire.getDirection();
		
		this.direction += direction;
                //���������{�����ۂ����������i�O�ւ��]�������������ԑ̂���]����̂ŁA���x0�̂Ƃ��̉�]���~�܂�B�z�C�[���x�[�X18m�Ƃ��ĊȈՌv�Z�j
//		this.direction += (int)((double)speed * Math.sin((double)direction * Math.PI / 180.0) * 3.0 / Math.PI);
		this.direction %= 360;             //������-359�`+359�ɂ���
		if(this.direction > 179){          //������-180�`+179�ɂ���
			this.direction -= 360;
		}else if(this.direction < -180){
			this.direction += 360;
		}
		
		x = x + (double)speed * Math.sin((double)this.direction * Math.PI / 180.0) / 3.6;
		y = y + (double)speed * Math.cos((double)this.direction * Math.PI / 180.0) / 3.6;
	}
}
