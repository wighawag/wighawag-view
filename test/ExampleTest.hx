package;

import com.wighawag.view.View;
import com.wighawag.view.BasicViewLayer;
import com.wighawag.view.sprite.BasicSpriteViewFactory;
import com.wighawag.asset.spritesheet.Sprite;
import com.wighawag.asset.load.Batch;
import com.wighawag.system.Model;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class ExampleTest 
{
	private var timer:Timer;
	
	public function new() 
	{
	    var factory = new BasicSpriteViewFactory(new Batch<Sprite>([]));
        var layer = new BasicViewLayer(new Model(),factory);
        var view = new View(null, [layer]);
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	
	@Test
	public function testExample():Void
	{
		Assert.isTrue(true);
	}
	
	@AsyncTest
	public function testAsyncExample(factory:AsyncFactory):Void
	{
		var handler:Dynamic = factory.createHandler(this, onTestAsyncExampleComplete, 300);
		timer = Timer.delay(handler, 200);
	}
	
	private function onTestAsyncExampleComplete():Void
	{
		Assert.isFalse(false);
	}
	
	
	/**
	* test that only runs when compiled with the -D testDebug flag
	*/
	@TestDebug
	public function testExampleThatOnlyRunsWithDebugFlag():Void
	{
		Assert.isTrue(true);
	}

}