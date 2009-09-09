package jp.wxd.utils 
{
	import flash.utils.ByteArray;
	/**
	 * <p>Objectのdeep copyを実行する関数です。</p>
	 */
	public function clone(object:Object):Object
	{
		var byteArray:ByteArray = new ByteArray();
		byteArray.writeObject(object);
		byteArray.position = 0;
		return byteArray.readObject();
	}
}