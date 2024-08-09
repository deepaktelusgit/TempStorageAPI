package feature;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class TestRunner 
{
	@Test
	public void testParallel() {
		Results results = Runner.path("classpath:feature").outputCucumberJson(true).parallel(1);
        assertTrue(results.getFailCount()==0, results.getErrorMessages());
        generateReport(results.getReportDir());
    }
	
	public void generateReport(String karateOutputPath){
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
		final List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"),"CCAI_Automation");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}
}
