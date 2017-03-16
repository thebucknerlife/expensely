class Receipt < ApplicationRecord
  has_one :request_item

  after_initialize :generate_cloudinary_public_id

  def generate_cloudinary_public_id
    self.cloudinary_public_id = loop do
      rand = sprintf('%06d', rand(1..999999))
      public_id = "#{tree_names.sample}-#{rand}"
      break public_id unless Receipt.exists?(cloudinary_public_id: public_id)
    end
  end

  def original_url
    cloudinary_json['url']
  end

  def url
    if pdf?
      pdf_to_image
    else
      cloudinary_json['url'].dup
    end
  end

  def pdf?
    original_url.match(/\.pdf$/)
  end

  def pdf_to_image
    original_url.gsub(/\.pdf$/,".jpeg")
  end

  def accountant_url
    @accountant_url ||= begin
      insert_pos = url.index(/\/upload/)+7
      url.insert(insert_pos, '/w_1000,h_1000,c_limit')
    end
  end

  def thumbnail_url
    @thumbnail ||= begin
      insert_pos = url.index(/\/upload/)+7
      url.insert(insert_pos, '/w_250,h_250,c_fit')
    end
  end

  def tree_names
    [
      "acacia-podalyriifolia",
      "acacia-simplex",
      "acai-palm",
      "aextoxicon",
      "aiphanes",
      "albizia-inundata",
      "alchornea-glandulosa",
      "alnus-acuminata",
      "alnus-jorullensis",
      "amburana-cearensis",
      "anadenanthera-peregrina",
      "aniba-rosaeodora",
      "annona-reticulata",
      "aspidosperma-cylindrocarpon",
      "aspidosperma-macrocarpon",
      "aspidosperma-polyneuron",
      "aspidosperma-quebracho-blanco",
      "aspidosperma-subincanum",
      "aspidosperma-tomentosum",
      "aspidosperma-ulei",
      "aspidosperma-vargasii",
      "astrocaryum-aculeatum",
      "astrocaryum-chambira",
      "attalea-palm",
      "bactris-campestris",
      "bactris-major",
      "bactris-setulosa",
      "bactris-simplicifrons",
      "banyan",
      "bursera-graveolens",
      "bursera-simaruba",
      "capparis-cynophallophora",
      "cavanillesia-platanifolia",
      "cedrela-fissilis",
      "ceiba-pentandra",
      "conocarpus-erectus",
      "copernicia",
      "desmoncus",
      "desmoncus-orthacanthos",
      "desmoncus-polyacanthos",
      "euterpe-precatoria",
      "ficus-americana",
      "ficus-citrifolia",
      "ficus-insipida",
      "ficus-maxima",
      "ficus-pakkensis",
      "ficus-trigonata",
      "geonoma",
      "gliricidia-sepium",
      "guatteria",
      "hancornia",
      "hancornia-speciosa",
      "handroanthus-chrysotrichus",
      "hasseltia",
      "hymenaea-courbaril",
      "inga-alba",
      "lecythis-ampla",
      "libidibia-ferrea",
      "manicaria",
      "margaritaria-nobilis",
      "mauritia",
      "mauritiella",
      "myrceugenia",
      "myrciaria-floribunda",
      "ochroma",
      "ochroma-pyramidale",
      "oenocarpus-bacaba",
      "pachira-aquatica",
      "papaya",
      "pithecellobium-dulce",
      "plathymenia",
      "pleuranthodendron",
      "prestoea",
      "quercus-corrugata",
      "rollinia-deliciosa",
      "roupala-montana",
      "sapindus-saponaria",
      "schinopsis-heterophylla",
      "senegalia-tenuifolia",
      "senegalia-visco",
      "spondias-mombin",
      "syagrus-romanzoffiana",
      "tabebuia-chrysotricha",
      "tabebuia-ochracea",
      "tabebuia-serratifolia",
      "tabernaemontana-longipes",
      "tachigali-versicolor",
      "theobroma-bicolor",
      "trigonobalanus-excelsa",
      "vachellia-horrida",
      "zollernia",
    ]
  end
end
