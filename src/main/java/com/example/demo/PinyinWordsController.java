package com.example.demo;

import com.lowagie.text.pdf.BaseFont;
import com.rnkrsoft.bopomofo4j.Bopomofo4j;
import com.rnkrsoft.bopomofo4j.ToneType;
import freemarker.template.Configuration;
import freemarker.template.Template;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;


@Controller
public class PinyinWordsController {
    private static final Logger logger = LoggerFactory.getLogger(PinyinWordsController.class);
    private static final String TemplatePath = "/home/pinyinwords";
    private Configuration pdfConf = null;

    @RequestMapping(value = "")
    public String index(Model model){
        return "input";
    }

    @RequestMapping(value = "input")
    public String input(Model model){
        return "input";
    }

    @PostConstruct
    public void init(){
        logger.info("init Bopomofo4j.sandbox ...");
        Bopomofo4j.sandbox();
        logger.info("Bopomofo4j test: 好好学习 " + Bopomofo4j.pinyin("好好学习", ToneType.WITH_VOWEL_TONE,false,false, " "));

        logger.info("init pdfConf ...");
        pdfConf = new Configuration(Configuration.getVersion());
        pdfConf.setDefaultEncoding("utf-8");
        pdfConf.setEncoding(Locale.CHINA, "utf-8");
        try {
            pdfConf.setDirectoryForTemplateLoading(new File(TemplatePath));
//          pdfConf.setClassForTemplateLoading(this.getClass(),"/");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "make")
    public String make(String title, String words,String tool,Integer rowsPerPage, Model model) {
        try{
            List<String> ww = Arrays.asList(words.split("\\s"));
            List<WordPingyin> wpList = new ArrayList();

            HanyuPinyinOutputFormat pyformat = new HanyuPinyinOutputFormat();
            pyformat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
            pyformat.setToneType(HanyuPinyinToneType.WITH_TONE_MARK);
            pyformat.setVCharType(HanyuPinyinVCharType.WITH_U_UNICODE);

            String str = "";
            for(String w : ww){
                if(w == null) continue;
                //String w = oneWord.replaceAll("[`qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……& amp;*（）——+|{}【】‘；：”“’。，、？|-]", "");
                if(w.trim().length() == 0)
                    continue;
                if("pinyin4j".equals(tool)){
                    str = PinyinHelper.toHanYuPinyinString(w, pyformat," ",true);
                } else if("bopomofo4j".equals(tool)){
                    str = Bopomofo4j.pinyin(w, ToneType.WITH_VOWEL_TONE,false,true, " ");
                }
                wpList.add( new WordPingyin(w,str) );
            }
            if(!StringUtils.isEmpty(title)){
                model.addAttribute("title",title);
            }
            model.addAttribute("tool",tool);
            model.addAttribute("words",wpList);
            model.addAttribute("rowsPerPage",rowsPerPage);

            logger.info("转换成功："+wpList.size());
            return "print";
        } catch (Exception ex){
            logger.error("转换失败！",ex);
            return "input";
        }
    }

    @Deprecated
    @RequestMapping(value = "pdf")
    public void pdf(RequestModel requestModel, HttpServletResponse response) throws Exception{
        List<WordPingyin> pywords = requestModel.getPywords();
        String title = requestModel.getTitle();
        Integer flag = 1;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Writer writer = new BufferedWriter(new OutputStreamWriter(baos, "UTF-8"));
//      Writer writer = response.getWriter();
        Template template = pdfConf.getTemplate("print_pdf.ftl");
        Map<String, Object> dataMap = new HashMap<String, Object>();
        if(requestModel.getPywords() != null && !pywords.isEmpty()){
            //title = pywords.get(0).getWord();
            //pywords.remove(0);
            dataMap.put("title",title);
            dataMap.put("pywords",pywords);
        }
        template.process(dataMap, writer);
        writer.flush();
        writer.close();

        // 生成ITextRenderer实例
        ITextRenderer renderer = new ITextRenderer();
        ITextFontResolver fontResolver = renderer.getFontResolver();
        //renderer.getSharedContext().setBaseURL("file://D:/data/idcboss/print_model/");

        renderer.getSharedContext().setReplacedElementFactory(new Base64ImgForPDFReplacedElementFactory());
        renderer.getSharedContext().getTextRenderer().setSmoothingThreshold(0);

        fontResolver.addFont(TemplatePath + "/arialuni.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        fontResolver.addFont(TemplatePath + "/simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); // BaseFont.EMBEDDED);

        renderer.setDocumentFromString(baos.toString());

        renderer.getSharedContext().setBaseURL(TemplatePath);

        renderer.layout();


        String fname = new String((title+".pdf").getBytes("UTF-8"), "UTF-8");
//        response.setContentType("application/octet-stream");
//        response.setCharacterEncoding("gb2312");
        response.setContentType("application/pdf;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("content-disposition", "attachment;filename=\"" + fname + "\"");

        renderer.createPDF(response.getOutputStream());

        renderer.finishPDF();
        renderer = null;
    }

}
